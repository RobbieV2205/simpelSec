resource "proxmox_vm_qemu" "simpelsec_VM06" {
  name        = "VM06"
  desc        = "VM06 Grafana"
  vmid        = 115
  target_node = "prox02"

ha {
    group = "ha-group01"   # CHECK DIT NA IK WEET NIET WAT DE NAAM WAS VAN ONZE CLUSTER
    state = "started"      # Andere opties: "stopped", "ignored"
  }

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
    storage = "proxPool"
    type    = "scsi"
    size    = "128G"
  }

 os_type = "cloud-init"
  # ip = ipv4, gw = default gateway
  ipconfig0  = "ip=172.10.50.100/24,gw=172.10.50.1"
  nameserver = "172.10.50.3"
  cluster     = "ProxCluster01"
}
