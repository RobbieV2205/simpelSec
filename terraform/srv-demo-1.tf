resource "proxmox_vm_qemu" "srv_demo_1" {
  name        = "srv-demo-1"
  desc        = "srv-demo-1"
  vmid        = "201"
  target_node = "proxmoxserver"

  agent = 1

  clone   = "ubuntu-template"
  cores   = 2
  sockets = 2
  cpu     = "host"
  memory  = 4096

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = "64G"
  }

  os_type = "cloud-init"
  # ip = ipv4, gw = default gateway
  ipconfig0  = "ip=192.168.1.30/24,gw=192.168.1.254"
  nameserver = "192.168.1.24"
  ciuser     = "robbie"
}