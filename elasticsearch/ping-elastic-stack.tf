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

# ELASTICSEARCH DATASTORES
data "vsphere_datastore" "datastore02" {
  name          = "HX-Datastore-02"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore01" {
  name          = "HX-Datastore-01"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# ELASTICSEARCH RESOURCE POOLS
data "vsphere_resource_pool" "pool" {
  name          = "PING-ELASTIC"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# ELASTICSEARCH NETWORKS
data "vsphere_network" "elasticsearch-970" {
  name          = "PING-ELASTICSEARCH_PRI-970"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "logstash-971" {
  name          = "PING-LOGSTASH_PRI-971"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "kibana-972" {
  name          = "PING-KIBANA_PRI-972"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# ELASTIC TEMPLATE
data "vsphere_virtual_machine" "template" {
  name          = "ELASTIC_TEMPLATE"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# ELASTICSEARCH VMS
resource "vsphere_virtual_machine" "DUN-BS-EL-M-01" {
  name             = "DUN-BS-EL-M-01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore02.id
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  num_cpus = 4
  memory   = 32000
  guest_id = "centos7_64Guest"

  network_interface {
    network_id = data.vsphere_network.elasticsearch-970.id
  }

  disk {
    label = "disk0"
    size  = 150
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "DUN-BS-EL-M-01"
        domain = "ping-ns.com"
      }
      network_interface {
        ipv4_address = "172.29.97.10"
        ipv4_netmask = 26
      }
      ipv4_gateway = "172.29.97.62"
    }
  }
  # cdrom {
  #    datastore_id = data.vsphere_datastore.datastore01.id
  #    path         = "ISO/CentOS-8.1.1911-x86_64-dvd1.iso"
  # }
}

resource "vsphere_virtual_machine" "DUN-BS-EL-D-01" {
  name             = "DUN-BS-EL-D-01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore02.id
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  num_cpus = 4
  memory   = 32000
  guest_id = "centos7_64Guest"

  network_interface {
    network_id = data.vsphere_network.elasticsearch-970.id
  }

  disk {
    label = "disk0"
    size  = 150
  }

    clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "DUN-BS-EL-D-01"
        domain = "ping-ns.com"
      }
      network_interface {
        ipv4_address = "172.29.97.11"
        ipv4_netmask = 26
      }
      ipv4_gateway = "172.29.97.62"
    }
  }
}

resource "vsphere_virtual_machine" "DUN-BS-EL-D-02" {
  name             = "DUN-BS-EL-D-02"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore02.id
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  num_cpus = 4
  memory   = 32000
  guest_id = "centos7_64Guest"

  network_interface {
    network_id = data.vsphere_network.elasticsearch-970.id
  }

  disk {
    label = "disk0"
    size  = 150
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "DUN-BS-EL-D-02"
        domain = "ping-ns.com"
      }
      network_interface {
        ipv4_address = "172.29.97.12"
        ipv4_netmask = 26
      }
      ipv4_gateway = "172.29.97.62"
    }
  }
}

# LOGSTASH VMS
resource "vsphere_virtual_machine" "DUN-BS-LS-01" {
  name             = "DUN-BS-LS-01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore02.id
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  num_cpus = 4
  memory   = 16000
  guest_id = "centos7_64Guest"

  network_interface {
    network_id = data.vsphere_network.logstash-971.id
  }

  disk {
    label = "disk0"
    size  = 150
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "DUN-BS-LS-01"
        domain = "ping-ns.com"
      }
      network_interface {
        ipv4_address = "172.29.97.66"
        ipv4_netmask = 26
      }
      ipv4_gateway = "172.29.97.125"
  }
}
}

# KIBANA VMS
resource "vsphere_virtual_machine" "DUN-BS-KIB-01" {
  name             = "DUN-BS-KIB-01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore02.id
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  num_cpus = 4
  memory   = 16000
  guest_id = "centos7_64Guest"

  network_interface {
    network_id = data.vsphere_network.kibana-972.id
  }

  disk {
    label = "disk0"
    size  = 150
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "DUN-BS-LS-01"
        domain = "ping-ns.com"
      }
      network_interface {
        ipv4_address = "172.29.97.130"
        ipv4_netmask = 26
      }
      ipv4_gateway = "172.29.97.190"
  }
 }
}
dmo
