# iac-gcp-\<recurso\>

Projeto Terraform para provisionar `<recurso>` no GCP, seguindo a convenção `terraform-best-practices`.

## Uso

```bash
terraform init -backend-config=backend.hcl

terraform workspace select dev || terraform workspace new dev

terraform plan -var-file=dev.tfvars
```

`terraform apply` é responsabilidade de quem está operando este repo, não deste template — rode manualmente quando estiver pronto, nunca de forma automatizada sem revisão do plano.

## Módulo consumido

- Fonte: `tf-modules` (`gcp/<modulo>`)
- Versão: ver `ref=` em `main.tf` — sempre uma tag, nunca uma branch.

## Ambientes

Este repo usa Terraform workspace nativo (`dev`, `stage`, `prod`) em vez de diretório por ambiente. O state de cada ambiente é isolado automaticamente pelo backend.
