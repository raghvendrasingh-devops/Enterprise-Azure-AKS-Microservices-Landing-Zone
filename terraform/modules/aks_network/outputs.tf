output "vnet_id" { value = azurerm_virtual_network.aks_vnet.id }
output "system_subnet_id" { value = azurerm_subnet.system_nodes_subnet.id }
output "user_subnet_id" { value = azurerm_subnet.user_nodes_subnet.id }
output "pe_subnet_id" { value = azurerm_subnet.pe_subnet.id }
