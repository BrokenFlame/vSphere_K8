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

variable "memory"{
    default= 16384    #Memory is in MB
    description = "The default memory used on vSphere to create a virtual machine"
}

variable "num_cpus" {
  default = 4
  description = "The default number of vCPUs to assign to the virtual machines." 
}

variable "num_cluster_nodes" {
  default = 3
  description = "The default number of nodes for Kubernetes in vSphere."
}

variable "disk_size" {
  default = 60
  description = "The default size for the disk in Giga Bytes."
}

variable "host_ip_addresses" {
  type = list
  default = ["192.168.0.1", "192.168.0.2", "192.168.0.3"]
}

variable "host_domain" {
  default = "domain.com"
  description = "The domain to which the hosts belong."
}

variable "host_netmask" {
  default = "255.255.0.0"
}

variable "host_gateway" {
  default = "172.16.11.1"
  description = "The default gateway for the virtual machines to use."
}

variable "host_dns" {
    default = "172.16.11.2"
    description = "The default DNS server IP address for vSphere guest VMs."
}

variable "ntp_server" {
    default = "0.pool.ntp.org"
    description = "The default NTP servers for the vShpere guess VMs."
}