locals {
  nsg_rules = { #aquí se define un mapa de reglas de seguridad
    "allow_http" = {
      priority               = 100
      destination_port_range = "80"
      description            = "Allow HTTP"

    }
    "allow_https" = {
      priority               = 110
      destination_port_range = "443"
      description            = "Allow HTTPS"

    }
  }
}
