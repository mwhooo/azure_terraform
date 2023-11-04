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