resource "proxmox_vm_qemu" "simpelsec_VM05" {
  name        = "VM05"
  desc        = "VM05 Datbase"
  vmid        = 113
  target_node = "prox02"

ha {
    group = "ha-group01"   # Naam van je HA-groep in Proxmox
    state = "started"      # Andere opties: "stopped", "ignored"
  }

  agent = 1

  clone   = "ubuntu-template"
  cores   = 2
  sockets = 2
  cpu     = "host"
  memory  = 8192

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = "proxPool"
    type    = "scsi"
    size    = "128G"
  }

  os_type = "cloud-init"
  # ip = ipv4, gw = default gateway
  ipconfig0  = "ip=172.10.50.91/24,gw=172.10.50.1"
  nameserver = "172.10.50.3"
  cluster     = "ProxCluster01"
}