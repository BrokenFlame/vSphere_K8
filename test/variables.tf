variable vsphere_server{
default = ""
  description ="The default server used on vSphere to create a Kubernetes Cluster to host the master Rancher Nodes"
}
variable vsphere_user{
    default = ""
  description ="The default user name  used on vSphere to create a Kubernetes Cluster to host the master Rancher Nodes"

}
variable vsphere_password{
    default = ""
  description ="The default password used on vSphere to create a Kubernetes Cluster to host the master Rancher Nodes"

}


variable guest_id {
  default = "opensuse15sp3gi"
  description = "The default image used on vSphere to create a Kubernetes Cluster to host the master Rancher Nodes"
}
variable "vsphere_compute_cluster" {
     default = "StandaloneCluster"
     description = "The default cluster used on vSphere to create a virtual machine"
}
variable "vsphere_datastore" {
    default = "ME4084-Perth-PoolB"
    description = "The default data store used on vSphere to create a virtual machine"
}
variable "vsphere_datacenter"{
    default = "PTC"
    description = "The default data center used on vSphere to create a Kubernetes Cluster to host the master Rancher Nodes"
}
variable "vsphere_network"{
    default= "PG-VLAN54"
    description = "The default Network used on vSphere to create a virtual machine"
}
variable "vsphere_virtual_machine"{
    default= "test"
    description = "The default Name used on vSphere to create a virtual machine"
}
variable "vsphere_content_library"{
    default= "Host_Library"
    description = "The default Content Library used on vSphere to create a virtual machine"
}
variable "ovf_name"{
    default= "opensuse15sp3gi"
    description = "The default ovf Name used on vSphere to create a virtual machine"
}
variable "label"{
    default= "disk0"
    description = "The default disk used on vSphere to create a virtual machine"
}

variable "size"{
    default= 20      #Disk size is in MB
    description = "The default Disk size used on vSphere to create a virtual machine"
}
variable "memory"{
    default= 1024    #Memory is in MB
    description = "The default memory used on vSphere to create a virtual machine"


}

