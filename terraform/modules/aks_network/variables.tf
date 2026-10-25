variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "vnet_name" { type = string; default = "vnet-spoke-aks-prod" }
variable "address_space" { type = string; default = "172.16.48.0/20" }
variable "system_subnet_prefix" { type = string; default = "172.16.48.0/22" }
variable "user_subnet_prefix" { type = string; default = "172.16.52.0/22" }
variable "pe_subnet_prefix" { type = string; default = "172.16.57.0/24" }
variable "tags" { type = map(string); default = {} }
