resource "random_string" "resource_code" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "${var.environment_name}state${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.rg-terraform-app.name
  location                 = azurerm_resource_group.rg-terraform-app.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  tags = {
    environment = var.environment_name
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate${var.environment_name}"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
}
