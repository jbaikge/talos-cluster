variable "cluster_name" {
  description = "A name to provide for the Talos cluster"
  type        = string
  default     = "bluey"
}

variable "cluster_endpoint" {
  description = "The endpoint for the Talos cluster"
  type        = string
  default     = "https://bartlebee.bluey.baconvacation.com:6443"
}

variable "nodes" {
  description = "A map of node data"
  type = object({
    controlplanes = map(object({
      install_disk = string
      hostname     = optional(string)
    }))
    workers = map(object({
      install_disk = string
      hostname     = optional(string)
    }))
  })
  default = {
    controlplanes = {
      "bartlebee.bluey.baconvacation.com" = {
        install_disk = "/dev/sda"
        hostname     = "bartlebee"
      },
    }
    workers = {
      "bartlebee.bluey.baconvacation.com" = {
        install_disk = "/dev/nvme0n1"
        hostname     = "bartlebee"
      },
      "frisky.bluey.baconvacation.com" = {
        install_disk = "/dev/nvme0n1"
        hostname     = "frisky"
      },
      "muffin.bluey.baconvacation.com" = {
        install_disk = "/dev/nvme0n1"
        hostname     = "muffin"
      },
    }
  }
}
