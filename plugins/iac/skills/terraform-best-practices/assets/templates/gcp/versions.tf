terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0" # ajuste para a versão vigente do provider ao criar o projeto
    }
  }
}
