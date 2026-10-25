terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_aks" {
  name     = "rg-enterprise-aks-prod"
  location = var.location
  tags     = var.tags
}

# 1. Spoke Network
module "network" {
  source              = "../../modules/aks_network"
  resource_group_name = azurerm_resource_group.rg_aks.name
  location            = var.location
  vnet_name           = "vnet-aks-enterprise-prod"
  tags                = var.tags
}

# 2. Private AKS Cluster
module "aks" {
  source              = "../../modules/aks_cluster"
  resource_group_name = azurerm_resource_group.rg_aks.name
  location            = var.location
  system_subnet_id    = module.network.system_subnet_id
  user_subnet_id      = module.network.user_subnet_id
  cluster_name        = "aks-enterprise-core-prod"
  aad_admin_group_id  = var.aad_admin_group_id
  tags                = var.tags
}

# 3. Azure Container Registry (ACR) Premium
module "acr" {
  source                     = "../../modules/aks_acr"
  resource_group_name        = azurerm_resource_group.rg_aks.name
  location                   = var.location
  kubelet_identity_object_id = module.aks.kubelet_identity_object_id
  acr_name                   = var.acr_name
  tags                       = var.tags
}
