resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" { #aquí se define un bloque dinámico que se va a ejecutar para cada elemento del mapa de reglas de seguridad siempre que va un dynamic se tiene que poner un content para definir el bloque que se va a ejecutarº
    for_each = local.nsg_rules
    content {
      name                       = security_rule.value.key                    #aqui se define el nombre de la regla
      priority                   = security_rule.value.priority               #aqui se define la prioridad de la regla
      direction                  = "Inbound"                                  #aqui se define la dirección de la regla
      access                     = "Allow"                                    #aqui se define el acceso de la regla
      protocol                   = "Tcp"                                      #aqui se define el protocolo de la regla
      source_port_range          = "*"                                        #aqui se define el puerto de origen de la regla
      destination_port_range     = security_rule.value.destination_port_range #aqui se define el puerto de destino de la regla
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}
