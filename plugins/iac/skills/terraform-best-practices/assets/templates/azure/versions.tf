terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # ajuste para a versão vigente do provider ao criar o projeto
    }
  }
}

provider "azurerm" {
  features {} # obrigatório no provider azurerm, mesmo vazio
}
