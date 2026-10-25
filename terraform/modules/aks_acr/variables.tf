variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "kubelet_identity_object_id" { type = string }
variable "acr_name" { type = string; default = "acrexpertiseplatform01" }
variable "tags" { type = map(string); default = {} }
