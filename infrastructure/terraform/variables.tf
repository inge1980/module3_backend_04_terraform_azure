variable "location" {
  default = "swedencentral"
}

variable "resource_group_name" {
  default = "terraform-azure-dotnet-demo-rg"
}

variable "virtual_network_name" {
  default = "terraform-demo-vnet"
}

variable "subnet_name" {
  default = "terraform-demo-subnet"
}

variable "network_security_group_name" {
  default = "terraform-demo-nsg"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
}