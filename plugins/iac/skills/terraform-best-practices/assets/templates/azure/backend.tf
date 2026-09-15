# Backend parcial — valores reais entram via `-backend-config` (arquivo .hcl ou flags),
# nunca hardcoded aqui.
#
# Exemplo de init:
#   terraform init -backend-config=backend.hcl
#
# A storage account e o container de state precisam existir antes deste init —
# normalmente provisionados fora deste projeto, para evitar o problema de
# "quem versiona o state do state".
#
# O state é isolado por ambiente automaticamente pelo Terraform workspace nativo
# (ver README.md deste repo) — não é necessário incluir o nome do ambiente na `key`.
terraform {
  backend "azurerm" {
    resource_group_name  = "" # preenchido via -backend-config
    storage_account_name = ""
    container_name       = ""
    key                  = "iac/<recurso>.tfstate"
  }
}
