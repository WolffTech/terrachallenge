# Module - Resource Group

A simple module for creating/managing Azure resource groups.

## Requirements
|Name|Version|
|---|---|
|terraform|>= 1.0.0 |

## Providers
|Name|Version|
|---|--|
|azurerm|>= 2.62.1|

## Inputs
|Name|Description|Type|Required|
|---|---|---|---|
|az_rg_name|The Name of the Resource Group|string|yes|
|az_rg_location|The Azure Region where the Resource Group should exist|string|yes|
|az_tags|A mapping of tags which should be assigned to all resources|map|no|

## Outputs
|Name|Description|
|---|---|
|az-rg-name|Resource azurerm_resource_group name|
|az-rg-location|Resource azurerm_resource_group location|
