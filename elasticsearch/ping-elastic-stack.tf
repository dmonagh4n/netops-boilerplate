provider "vsphere" {
	user = " " 
	password = " "
	vsphere_server = " "	
	# Environment Variable Equivilants
	# VSPHERE_USER, VSPHERE_PASSWORD and VSPHERE_SERVER	
	
	allow_unverified_ssl = true
}

# DATA_CENTRES
data "vsphere_datacenter" "dun-bs" {
  name = "Dundee"
}

# DATASTORES
data "vsphere_datastore" "HX-DS-01" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dun-bs.id
}
data "vsphere_datastore" "HX-DS-02" {
  name          = "datastore2"
  datacenter_id = data.vsphere_datacenter.dun-bs.id
}

# RESOURCE_POOLS
data "vsphere_resource_pool" "pool" {
  name          = "cluster1/PING-ELASTIC"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# NETWORKS
data "vsphere_network" "ELASTIC-970" {
  name          = "ELASTICSEARCH-970"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "LOGSTASH-971" {
  name          = "LOGSTASH-971"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "KIBANA-972" {
  name          = "KIBANA-972"
  datacenter_id = data.vsphere_datacenter.dc.id
}
