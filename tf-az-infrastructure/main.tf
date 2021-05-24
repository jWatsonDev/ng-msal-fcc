provider "azurerm" {
    features {}
}
 
data "azurerm_client_config" "current" {}
 
// create resource group
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group
  location = var.location
}
 
// create storage account
resource "azurerm_storage_account" "storage_account" {
  name                = var.storage_account
  resource_group_name = azurerm_resource_group.resource_group.name
 
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
 
  static_website {
    index_document = "index.html"
  }
}
 
// add placeholder index.html to blob
resource "azurerm_storage_blob" "example" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}