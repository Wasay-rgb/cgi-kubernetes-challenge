terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "cgi-aks-rg"
  location = "westeurope"

  tags = {
    author  = "wasay.ahmed@cgi.com"
    purpose = "cgi-automation-challenge"
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "cgi-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "cgiaks"

  default_node_pool {
    name       = "system"
    node_count = 2
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}
