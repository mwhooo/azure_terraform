variable "resource_group_location" {
  type        = string
  default     = "westeurope"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  default     = "azure-tf-demo"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "rg_tags" {
  type  = map(string)
  default = {
    tag1 = "tag1"
    tag2 = "tag2"
  }
  description = "Tags for RG"
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