variable "location" {
  default = "swedencentral"
}

variable "resource_group_name" {
  default = "terraform-azure-dotnet-rg"
}

variable "virtual_network_name" {
  default = "terraform-azure-vnet"
}

variable "subnet_name" {
  default = "terraform-azure-subnet"
}

variable "network_security_group_name" {
  default = "terraform-azure-nsg"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
}

variable "vm_name" {
  default = "terraform-azure-vm"
}

variable "admin_username" {
  default = "azureuser"
}

variable "vm_size" {
  default = "Standard_B2ats_v2"
}

variable "container_registry_name" {
  default = "terraformazuredotnetacr"
}