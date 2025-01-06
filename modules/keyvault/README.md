# Module - Key Vault

A simple module for creating an Azure Key Vault.

## Requirements

|Name|Version|
|---|---|
|terraform|>= 1.0.0|

## Providers
|Name|Version|
|---|--|
|azurerm|>= 2.62.1|

## Inputs
|Name|Description|Type|Required|
|---|---|---|---|
|name|Name of the Key Vault|string|true|
|location|Azure region where the Key Vault will be created|string|true|
|resource_group_name|Name of the resource group|string|true|
|enabled_for_disk_encryption|Enable Key Vaults for disk encryption|bool|false|
|soft_delete_retention_days|Soft delete retention days|number|false|
|purge_protection_enabled|Enable purge protection|bool|false|
|sku_name|SKU name for the Key Vault|string|true|


## Outputs
|Name|Description|
|---|---|
|id|The ID of the Key Vault|
|name|The name of the Key Vault|
|uri|The URI of the Key Vault|
|location|The location of the Key Vault|
