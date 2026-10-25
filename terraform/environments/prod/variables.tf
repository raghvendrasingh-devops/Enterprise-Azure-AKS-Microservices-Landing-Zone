variable "location" { type = string; default = "eastus2" }
variable "acr_name" { type = string; default = "acrexpertiseplatform01" }
variable "aad_admin_group_id" { type = string; default = "a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d" }
variable "tags" {
  type = map(string)
  default = {
    Environment = "Production"
    Owner       = "Raghvendra-Singh"
    Tier        = "Enterprise-AKS-Microservices"
    ManagedBy   = "Terraform"
  }
}
