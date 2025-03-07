resource "talos_machine_secrets" "this" {}

data "talos_machine_configuration" "controlplane" {
  cluster_name     = var.cluster_name
  cluster_endpoint = var.cluster_endpoint
  machine_type     = "controlplane"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}

data "talos_machine_configuration" "worker" {
  cluster_name     = var.cluster_name
  cluster_endpoint = var.cluster_endpoint
  machine_type     = "worker"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = [for k, v in var.nodes.controlplanes : k]
}

resource "talos_machine_configuration_apply" "controlplane" {
  for_each                    = var.nodes.controlplanes
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.controlplane.machine_configuration
  node                        = each.key
  config_patches = [
    templatefile("${path.module}/templates/disk.yaml", {
      install_disk = each.value.install_disk
    }),
    templatefile("${path.module}/templates/network.yaml", {
      hostname = each.value.hostname
      ip       = each.key
    }),
    templatefile("${path.module}/templates/pull-through-cache.yaml", {}),
    templatefile("${path.module}/templates/cluster-subnet.yaml", {}),
    templatefile("${path.module}/templates/cp-scheduling.yaml", {}),
  ]
}

resource "talos_machine_configuration_apply" "worker" {
  for_each                    = var.nodes.workers
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker.machine_configuration
  node                        = each.key
  config_patches = [
    templatefile("${path.module}/templates/disk.yaml", {
      install_disk = each.value.install_disk
    }),
    templatefile("${path.module}/templates/network.yaml", {
      hostname = each.value.hostname
      ip       = each.key
    }),
    templatefile("${path.module}/templates/pull-through-cache.yaml", {}),
    templatefile("${path.module}/templates/cluster-subnet.yaml", {}),
  ]
}

resource "talos_machine_bootstrap" "this" {
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = [for k, v in var.nodes.controlplanes : k][0]
  depends_on = [
    talos_machine_configuration_apply.controlplane,
  ]
}

resource "talos_cluster_kubeconfig" "this" {
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = [for k, v in var.nodes.controlplanes : k][0]
  depends_on = [
    talos_machine_bootstrap.this,
  ]
}
