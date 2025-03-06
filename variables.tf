variable "cluster_name" {
  description = "A name to provide for the Talos cluster"
  type        = string
  default     = "bluey"
}

variable "cluster_endpoint" {
  description = "The endpoint for the Talos cluster"
  type        = string
  default     = "https://bluey.baconvacation.com:6443"
}

variable "cluster_domain" {
  description = "Base domain for all cluster nodes"
  type        = string
  default     = "bluey.baconvacation.com"
}

variable "nodes" {
  description = "A map of node data"
  type = object({
    controlplanes = map(object({
      install_disk = string
    }))
    workers = map(object({
      install_disk = string
    }))
  })
  default = {
    controlplanes = {
      "bartlebee" = {
        install_disk = "/dev/nvme1n1"
      },
    }
    workers = {
      "frisky" = {
        install_disk = "/dev/nvme1n1"
      },
      "muffin" = {
        install_disk = "/dev/nvme1n1"
      },
    }
  }
}
