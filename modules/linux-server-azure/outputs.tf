output "vm_private_ip" {
  value = azurerm_network_interface.primary.private_ip_address
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}