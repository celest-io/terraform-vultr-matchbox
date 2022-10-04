variable "profile_name" {
  type        = string
  description = "Name of this matchbox profile."
  default     = "default"
}

variable "ssh_keys" {
  type        = list(string)
  description = "SSH public keys for user 'core'."
}

variable "os_channel" {
  type        = string
  description = "Flatcar Container Linux channel to install from (stable, beta, alpha, edge)."
  default     = "stable"
}

variable "os_version" {
  type        = string
  description = "Flatcar Container Linux version to install (for example '2191.5.0' - see https://www.flatcar-linux.org/releases/)."
  default     = "current"
}

variable "kernel_args" {
  type        = list(string)
  description = "Additional kernel arguments to provide at PXE boot and in /usr/share/oem/grub.cfg."
  default     = []
}

variable "kernel_console" {
  type        = list(string)
  description = "The kernel arguments to configure the console at PXE boot and in /usr/share/oem/grub.cfg."
  default     = ["console=tty0", "console=ttyS0"]
}

variable "install_disk" {
  type        = string
  description = "Disk device to which the install profiles should install the operating system (e.g. /dev/sda)."
  default     = "/dev/vda"
}

variable "matchbox_http_endpoint" {
  type        = string
  description = "Matchbox HTTP read-only endpoint (e.g. http://matchbox.example.com:8080)"
}

variable "wipe_previous_raid" {
  type        = bool
  description = "Wipes previous RAID setup, if set to true"
  default     = false
}

variable "wipe_additional_disks" {
  type        = bool
  description = "Wipes any additional disks attached, if set to true"
  default     = false
}

variable "root_raid_name" {
  type        = string
  description = "Name of the base partitions RAID label and the array name"
  default     = "root_raid"
}

variable "raid_on_install_disk" {
  type        = bool
  description = "Pre-create a RAID partition on the install disk, if set to true"
  default     = false
}
