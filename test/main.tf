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

resource "vsphere_virtual_disk" "virtual_disk" {
  size               = 40   #size in GB
  type               = "thin"
  vmdk_path          = "/RKE-Rancher/Test.vmdk"
  create_directories = true
  datacenter         = data.vsphere_datacenter.datacenter.name
  datastore          = data.vsphere_datastore.datastore.name
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vsphere_virtual_machine
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 1
  memory           = var.memory  # Memory is in MB
  guest_id         = var.guest_id
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = var.label
    size  = var.size
  }
}


/*

resource "vsphere_virtual_machine" "VM" {
  name             = var.vsphere_virtual_machine
  #resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  resource_pool_id= data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus   = 1
  memory     = 2048  # Memory is in MB
  cpu_hot_add_enabled = true
  cpu_hot_remove_enabled= true
  memory_hot_add_enabled =true

  wait_for_guest_net_timeout = 0

  guest_id = var.guest_id
  nested_hv_enabled =true
  network_interface{
   network_id     = data.vsphere_network.network.id
   adapter_type   = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
disk {
    label = "disk0"
    size  = 20  # Disk Space in GB
    }
 }




/*



data "vsphere_host" "host" {
  name          = "esxi-01.example.com"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "pool" {





disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
resource "vsphere_virtual_disk" "virtual_disk" {
  size               = 40
  type               = "thin"
  vmdk_path          = "/foo/foo.vmdk"
  create_directories = true
  datacenter         = data.vsphere_datacenter.datacenter.name
  datastore          = data.vsphere_datastore.datastore.name
}

}


*/