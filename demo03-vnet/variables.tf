variable "resource_group" {
  type        = map(string)
  default     = {
    name = "azure-tf-demo"
    location = "westeurope"
  }
  description = "Contains values for RG"
}

variable "address_space" {
  type        = string
  description = "Cidr range for the Virtual Network"
  default     = "10.0.0.0/16"
}

variable "vnet_name" {
  type = string
  description = "vnet name in azure"
  default = "demo-vnet"
}

variable "subnet1_name" {
  type = string
  description = "Subnet1 name"
  default = "Windows_Subnet"
}

variable "subnet2_name" {
  type = string
  description = "Subnet2 name"
  default = "Linux_Subnet"
}