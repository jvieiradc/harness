# Backend parcial — valores reais entram via `-backend-config` (arquivo .hcl ou flags),
# nunca hardcoded aqui. Isso evita nome de bucket comitado no repo.
#
# Exemplo de init:
#   terraform init -backend-config=backend.hcl
#
# O state é isolado por ambiente automaticamente pelo Terraform workspace nativo
# (ver README.md deste repo) — não é necessário incluir o nome do ambiente no `prefix`.
terraform {
  backend "gcs" {
    bucket = "" # preenchido via -backend-config
    prefix = "iac/<recurso>"
  }
}
