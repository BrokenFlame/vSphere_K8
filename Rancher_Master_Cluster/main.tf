provider "vsphere" {
    vsphere_server = var.vsphere_server
    user = var.vsphere_user
    password = var.vsphere_password
    allow_unverified_ssl = true
}

## Build VM

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "compute_cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
 datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_content_library" "library" {
  name = var.vsphere_content_library
}

data "vsphere_content_library_item" "item" {
  name       = var.ovf_name
  type       = "ovf"
  library_id = data.vsphere_content_library.library.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" host{
    name          = "esxi-3.poole.parkeon.com"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
resource "vsphere_resource_pool" "resource_pool" {
  name                    = "RKE-resource-poole-01"
  parent_resource_pool_id = data.vsphere_compute_cluster.compute_cluster.resource_pool_id
}
resource "vsphere_virtual_disk" "virtual_disk" {
  count              = var.num_cluster_nodes
  size               = var.disk_size   #size in GB
  type               = "thin"
  vmdk_path          = "/RKE-Rancher/RKE_node${count.index}.vmdk"
  create_directories = true
  datacenter         = data.vsphere_datacenter.datacenter.name
  datastore          = data.vsphere_datastore.datastore.name
}

resource "vsphere_virtual_machine" "vmFromLocalOvf" {
  count                = var.num_cluster_nodes
  name                 = "RKE_node${count.index}"
  datacenter_id        = data.vsphere_datacenter.datacenter.id
  datastore_id         = data.vsphere_datastore.datastore.id
  host_system_id       = data.vsphere_host.host.id
  resource_pool_id     = vsphere_resource_pool.resource_pool.id

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  ovf_deploy {
    allow_unverified_ssl_cert = false
    remote_ovf_url            = "/Volume/Storage/OVAs/foo.ova"
    disk_provisioning         = "thin"
    ip_protocol               = "IPV4"
    ip_allocation_policy      = "STATIC_MANUAL"
    ovf_network_map = {
      "Network 1" = data.vsphere_network.network.id
      "Network 2" = data.vsphere_network.network.id
    }
  }
  vapp {
    properties = {
      "guestinfo.hostname"     = "RKE_node${count.index}.${var.host_domain}",
      "guestinfo.ipaddress"    = var.host_ip_addresses[count.index],
      "guestinfo.netmask"      = var.host_netmask,
      "guestinfo.gateway"      = var.host_gateway,
      "guestinfo.dns"          = var.host_dns,
      "guestinfo.domain"       = var.host_domain,
      "guestinfo.ntp"          = var.ntp_server,
      "guestinfo.password"     = "VMware1!",
      "guestinfo.ssh"          = "True"
    }
  }
}