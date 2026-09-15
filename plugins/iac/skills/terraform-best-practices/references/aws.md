# Terraform na AWS — especificidades

Esta referência cobre o que é específico da AWS dentro da convenção descrita no `SKILL.md`. Leia o `SKILL.md` primeiro — aqui só entra o que muda por causa do provider.

## Metadado de recurso

Na AWS o mecanismo de metadado chama-se **tags** (mapa `key = value`). Convenção mínima recomendada para todo módulo e recurso:

```hcl
tags = merge(
  var.tags,
  {
    ManagedBy = "terraform"
    Repo      = "iac-aws-<recurso>"
  }
)
```

`var.tags` deve ser uma variável exposta pelo módulo (não um valor fixo), para que o consumidor possa adicionar suas próprias tags (custo, time responsável, ambiente etc.) sem editar o módulo.

## Backend de state recomendado

Backend `s3`, com locking. Duas variantes válidas — escolha conforme o que o time já usa ou o que a versão do Terraform em uso suportar:

- **S3 + DynamoDB** (padrão mais amplamente compatível): tabela DynamoDB dedicada ao lock.
  ```hcl
  terraform {
    backend "s3" {
      bucket         = "" # via -backend-config
      key            = "iac/<recurso>/terraform.tfstate"
      region         = ""
      dynamodb_table = ""
      encrypt        = true
    }
  }
  ```
- **S3 com locking nativo**: versões mais recentes do backend S3 suportam lock sem tabela DynamoDB separada. Se o time já usa essa variante, não é necessário criar a tabela — mas confirme que a versão de Terraform/provider em uso realmente suporta isso antes de assumir, em vez de copiar isso às cegas de um projeto mais novo.

Nunca deixe o backend sem locking configurado de alguma forma — sem lock, dois `apply` concorrentes podem corromper o state.

## `versions.tf`

```hcl
terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # ajuste para a versão vigente do provider ao criar o projeto
    }
  }
}
```

## Particularidades de nomenclatura

- Nomes de recursos IAM (roles, policies) devem incluir o nome do recurso/projeto para evitar colisão entre projetos na mesma conta (ex.: `iac-aws-vpc-execution-role`, não `execution-role`).
- Buckets S3 são globalmente únicos — nunca hardcode um nome de bucket dentro de um módulo; sempre receba por variável.

## Estrutura esperada em `tf-modules/aws/`

```
tf-modules/
  aws/
    vpc/
      main.tf
      variables.tf
      outputs.tf
      versions.tf
      CHANGELOG.md
    cloud-run-equivalente-etc/
      ...
```

Cada módulo é autocontido dentro da sua subpasta — sem depender de arquivos fora dela.
