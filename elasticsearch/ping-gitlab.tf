variable "vsphere_user" {
   description = "The vsphere user for terraform"
   type = string
}

variable "vsphere_password" {
   description = "The vsphere password for terraform"
   type = string
}

variable "vsphere_server" {
   description = "The target vsphere environment"
   type = string
}

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "Dundee"
}

# GITLAB DATASTORES
data "vsphere_datastore" "datastore02" {
  name          = "HX-Datastore-02"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore01" {
  name          = "HX-Datastore-01"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# GITLAB RESOURCE POOLS
data "vsphere_resource_pool" "pool" {
  name          = "PING-CICD"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# GITLAB NETWORKS
data "vsphere_network" "cicd-980" {
  name          = "PING-CICD_PRI"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# BASE TEMPLATE
data "vsphere_virtual_machine" "cicd_template" {
  name          = "GITLAB_TEMPLATE"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# GITLAB VMS
resource "vsphere_virtual_machine" "DUN-BS-CICD-01" {
  name             = "DUN-BS-CICD-01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore02.id
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  num_cpus = 4
  memory   = 32000
  guest_id = "centos7_64Guest"

  network_interface {
    network_id = data.vsphere_network.cicd-970.id
  }

  disk {
    label = "disk0"
    size  = 150
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.cicd.id

    customize {
      linux_options {
        host_name = "DUN-BS-CICD-01"
        domain = "ping-ns.com"
      }
      network_interface {
        ipv4_address = "172.29.98.1"
        ipv4_netmask = 26
      }
      ipv4_gateway = "172.29.98.13"
      dns_server_list = ["172.29.68.3", "172.30.68.3"]
    }
  }
  # cdrom {
  #    datastore_id = data.vsphere_datastore.datastore01.id
  #    path         = "ISO/CentOS-8.1.1911-x86_64-dvd1.iso"
  # }
}
