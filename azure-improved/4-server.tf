module server1 {
    source          = "../modules/linux-server-azure"
    rg_name         = azurerm_resource_group.demo_rg.name
    subnet_id       = azurerm_subnet.demo_snet.id
    hostname        = "${var.demo_name}01"
    admin_username  = var.demo_user
    admin_key       = var.demo_key
    tags            = map( "demo", var.demo_name )
}

module server2 {
    source          = "../modules/linux-server-azure"
    rg_name         = azurerm_resource_group.demo_rg.name
    subnet_id       = azurerm_subnet.demo_snet.id
    hostname        = "${var.demo_name}02"
    admin_username  = var.demo_user
    admin_key       = var.demo_key
    tags            = map( "demo", var.demo_name )
}