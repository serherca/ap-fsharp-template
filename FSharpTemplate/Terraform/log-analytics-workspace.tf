# terraform/log-analytics-workspace.tf

# Create Log Analytics Workspace related to App insights
resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.service_name}${var.environment_suffix}-law"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  retention_in_days   = 30
}

# Create Log Analytics Workspace linked storage account
resource "azurerm_log_analytics_linked_storage_account" "sa" {
  data_source_type      = "customlogs"
  resource_group_name   = azurerm_resource_group.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  storage_account_ids   = [azurerm_storage_account.sa.id]
}