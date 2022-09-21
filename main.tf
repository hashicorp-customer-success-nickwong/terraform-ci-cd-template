terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  backend "remote" {
    organization = "nw-tfc-test"

    workspaces {
      prefix = "nwong-demo-one-"
    }
  }
}

provider "azurerm" {
  features {}
}

module "stack_azure_virtual_machine_example" {
  source                       = "app.terraform.io/nw-tfc-test/stack_azure_virtual_machine_example/demo"
  resource_group_name          = format("%s%s", var.resource_group_name_prefix, var.deployment_environment)
  primary_cluster_size         = var.primary_cluster_size 
  secondary_cluster_size       = var.secondary_cluster_size
  include_demo_vm              = false
  tags = {
    environment      = var.deployment_environment
    application-name = "Demonstration"
    owner            = "Nick Wong"
  }
}
