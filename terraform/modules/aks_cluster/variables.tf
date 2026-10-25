variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "system_subnet_id" { type = string }
variable "user_subnet_id" { type = string }
variable "cluster_name" { type = string; default = "aks-enterprise-core-prod" }
variable "aad_admin_group_id" { type = string; default = "00000000-0000-0000-0000-000000000000" }
variable "tags" { type = map(string); default = {} }
