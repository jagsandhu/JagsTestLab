provider "azurerm" {
    version = "~>1.33"
}

resource "azurerm_resource_group" "rg" {
    name     = "hello-tf-azure-rg"
    location = "northeurope"
}

resource "azurerm_resource_group" "rg2" {
    name     = "hello-tf-azure-2-rg"
    location = "northeurope"
}
