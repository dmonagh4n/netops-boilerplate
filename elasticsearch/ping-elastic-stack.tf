provider "vsphere" {
	user = " " 
	password = " "
	vsphere_server = " "	
	# Environment Variable Equivilants
	# VSPHERE_USER, VSPHERE_PASSWORD and VSPHERE_SERVER	
	
	allow_unverified_ssl = true
}

data "vsphere_datacenter" "dun-bs" {
  name = "Dundee"
}

data "vsphere_datastore" "HX-DS-01" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dun-bs.id
}
