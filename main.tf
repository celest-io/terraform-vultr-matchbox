locals {
  flatcar_ipxe = <<EOT
#!ipxe

chain ${var.matchbox_http_endpoint}/ipxe?provider=vultr-${var.profile_name}
 EOT
}

resource "matchbox_profile" "vultr" {
  name   = "vultr-${var.profile_name}"
  kernel = "http://${var.os_channel}.release.flatcar-linux.net/amd64-usr/${var.os_version}/flatcar_production_pxe.vmlinuz"
  initrd = [
    "http://${var.os_channel}.release.flatcar-linux.net/amd64-usr/${var.os_version}/flatcar_production_pxe_image.cpio.gz",
  ]

  args = flatten([
    "initrd=flatcar_production_pxe_image.cpio.gz",
    "flatcar.config.url=${var.matchbox_http_endpoint}/ignition?uuid=$${uuid}&mac=$${mac:hexhyp}&provider=vultr-${var.profile_name}",
    "flatcar.first_boot=yes",
    "consoleblank=0",
    var.kernel_console,
    var.kernel_args,
  ])

  container_linux_config = templatefile("${path.module}/config/flatcar-install.yaml", {
    ssh_keys              = jsonencode(var.ssh_keys)
    install_disk          = var.install_disk
    kernel_console        = join(" ", var.kernel_console)
    kernel_args           = join(" ", var.kernel_args)
    wipe_previous_raid    = var.wipe_previous_raid
    wipe_additional_disks = var.wipe_additional_disks
    raid_on_install_disk  = var.raid_on_install_disk
    root_raid_name        = var.root_raid_name
    os_channel            = var.os_channel
    os_version            = var.os_version
    ignition_endpoint     = "http://169.254.169.254/latest/user-data"
  })
}

resource "matchbox_group" "vultr" {
  name    = "vultr-${var.profile_name}"
  profile = matchbox_profile.vultr.name

  metadata = {
    install_disk = var.install_disk
  }

  selector = {
    provider = "vultr-${var.profile_name}"
  }
}

resource "vultr_startup_script" "matchbox" {
  name   = "matchbox-${var.profile_name}"
  type   = "pxe"
  script = base64encode(local.flatcar_ipxe)
}
