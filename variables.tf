variable "cluster_name" {
  description = "A name to provide for the Talos cluster"
  type        = string
  default     = "bluey"
}

variable "cluster_endpoint" {
  description = "The endpoint for the Talos cluster"
  type        = string
  default     = "https://10.100.6.36:6443"
}

variable "nodes" {
  description = "A map of node data"
  type = object({
    controlplanes = map(object({
      install_disk = string
      data_disk    = string
      hostname     = string
    }))
    workers = map(object({
      install_disk = string
      data_disk    = string
      hostname     = string
    }))
  })
  default = {
    controlplanes = {
      "10.100.6.36" = {
        install_disk = "/dev/nvme1n1"
        data_disk    = "/dev/nvme0n1"
        hostname     = "bartlebee"
      },
    }
    workers = {
      "10.100.6.40" = {
        install_disk = "/dev/nvme1n1"
        data_disk    = "/dev/nvme0n1"
        hostname     = "frisky"
      },
      "10.100.6.44" = {
        install_disk = "/dev/nvme1n1"
        data_disk    = "/dev/nvme0n1"
        hostname     = "muffin"
      },
    }
  }
}
