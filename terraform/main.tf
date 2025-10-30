terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://172.10.50.40:8006/api2/json"
  pm_api_token_id     = "root@pam!tf-002"
  pm_api_token_secret = "d51f970c-a099-4549-a599-35339d805c7a"
  pm_tls_insecure     = true
}


resource "proxmox_vm_qemu" "tf-vm03" {
  vmid             = 120
  name             = "tf-vm04"
  target_node      = "prox02"
  agent            = 1
  cores            = 4
  memory           = 4096
  boot             = "order=scsi0"        # has to be the same as the OS disk of the template
  clone            = "debian12-cloudinit" # The name of the template
  scsihw           = "virtio-scsi-single"
  vm_state         = "running"
  automatic_reboot = true

  # Cloud-Init configuration
  cicustom   = "vendor=local:snippets/qemu-guest-agent.yml" # /var/lib/vz/snippets/qemu-guest-agent.yml
  ciupgrade  = true
  nameserver = "1.1.1.1 8.8.8.8"
  ipconfig0  = "ip=172.10.50.43/24,gw=172.10.50.1,ip6=dhcp"
  skip_ipv6  = true
  ciuser     = "root"
  cipassword = "oversleepnumeric"
  sshkeys    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIALgSOzz3tohGIWggRE8o+k6iewKaO2uc4w9g8rQnFo2 robbie@Laptop01"

  # Most cloud-init images require a serial device for their display
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "proxPool"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size = "64G"
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "proxPool"
        }
      }
    }
  }

  network {
    id     = 0
    bridge = "vmbr0"
    model  = "virtio"
  }
}


resource "proxmox_vm_qemu" "tf-vm04" {
  vmid             = 121
  name             = "tf-vm04"
  target_node      = "prox02"
  agent            = 1
  cores            = 4
  memory           = 4096
  boot             = "order=scsi0"        # has to be the same as the OS disk of the template
  clone            = "debian12-cloudinit" # The name of the template
  scsihw           = "virtio-scsi-single"
  vm_state         = "running"
  automatic_reboot = true

  # Cloud-Init configuration
  cicustom   = "vendor=local:snippets/qemu-guest-agent.yml" # /var/lib/vz/snippets/qemu-guest-agent.yml
  ciupgrade  = true
  nameserver = "1.1.1.1 8.8.8.8"
  ipconfig0  = "ip=172.10.50.84/24,gw=172.10.50.1,ip6=dhcp"
  skip_ipv6  = true
  ciuser     = "root"
  cipassword = "oversleepnumeric"
  sshkeys    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIALgSOzz3tohGIWggRE8o+k6iewKaO2uc4w9g8rQnFo2 robbie@Laptop01"

  # Most cloud-init images require a serial device for their display
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "proxPool"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size = "64G"
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "proxPool"
        }
      }
    }
  }

  network {
    id     = 0
    bridge = "vmbr0"
    model  = "virtio"
  }
}


resource "proxmox_vm_qemu" "tf-vm05" {
  vmid             = 122
  name             = "tf-vm05"
  target_node      = "prox02"
  agent            = 1
  cores            = 4
  memory           = 4096
  boot             = "order=scsi0"        # has to be the same as the OS disk of the template
  clone            = "debian12-cloudinit" # The name of the template
  scsihw           = "virtio-scsi-single"
  vm_state         = "running"
  automatic_reboot = true

  # Cloud-Init configuration
  cicustom   = "vendor=local:snippets/qemu-guest-agent.yml" # /var/lib/vz/snippets/qemu-guest-agent.yml
  ciupgrade  = true
  nameserver = "1.1.1.1 8.8.8.8"
  ipconfig0  = "ip=172.10.50.85/24,gw=172.10.50.1,ip6=dhcp"
  skip_ipv6  = true
  ciuser     = "root"
  cipassword = "oversleepnumeric"
  sshkeys    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIALgSOzz3tohGIWggRE8o+k6iewKaO2uc4w9g8rQnFo2 robbie@Laptop01"

  # Most cloud-init images require a serial device for their display
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "proxPool"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size = "64G"
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "proxPool"
        }
      }
    }
  }

  network {
    id     = 0
    bridge = "vmbr0"
    model  = "virtio"
  }
}

# bron vermelding: https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/guides/cloud-init%2520getting%2520started