# Backend parcial — valores reais entram via `-backend-config` (arquivo .hcl ou flags),
# nunca hardcoded aqui. Isso evita credencial/nome de bucket comitado no repo.
#
# Exemplo de init:
#   terraform init -backend-config=backend.hcl
#
# O state é isolado por ambiente automaticamente pelo Terraform workspace nativo
# (ver README.md deste repo) — não é necessário incluir o nome do ambiente na `key`.
terraform {
  backend "s3" {
    bucket         = "" # preenchido via -backend-config
    key            = "iac/<recurso>/terraform.tfstate"
    region         = ""
    dynamodb_table = "" # lock table — omitir apenas se o backend S3 em uso já tiver locking nativo confirmado
    encrypt        = true
  }
}
