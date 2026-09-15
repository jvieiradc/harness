# Terraform no GCP — especificidades

Esta referência cobre o que é específico do Google Cloud dentro da convenção descrita no `SKILL.md`. Leia o `SKILL.md` primeiro — aqui só entra o que muda por causa do provider.

## Metadado de recurso

No GCP o mecanismo de metadado chama-se **labels**, não tags — e tem restrições que a AWS não tem: chaves e valores só aceitam minúsculas, números, `_` e `-`, e alguns tipos de recurso não aceitam labels. Convenção mínima recomendada:

```hcl
labels = merge(
  var.labels,
  {
    managed_by = "terraform"
    repo       = "iac-gcp-<recurso>"
  }
)
```

`var.labels` deve ser uma variável exposta pelo módulo. Ao adaptar um template vindo de outro provider, não copie `tags` literalmente — o nome do argumento no recurso Terraform é `labels`, e o formato de valor é mais restrito.

## Backend de state recomendado

Backend `gcs`, que já tem locking nativo (sem precisar de uma tabela/recurso adicional para isso):

```hcl
terraform {
  backend "gcs" {
    bucket = "" # via -backend-config
    prefix = "iac/<recurso>"
  }
}
```

## `versions.tf`

```hcl
terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0" # ajuste para a versão vigente do provider ao criar o projeto
    }
  }
}
```

Se o recurso precisar de features em preview/beta, use `google-beta` como provider adicional em vez de assumir que `google` cobre tudo.

## Particularidades de nomenclatura

- Nomes de recurso no GCP costumam ter regras mais rígidas de tamanho/charset que AWS/Azure (ex.: nomes de projeto, de bucket, de service account) — sempre valide o padrão do recurso específico em vez de assumir que o nome kebab-case do repo (`iac-gcp-<recurso>`) serve como nome de recurso sem adaptação.
- IDs de projeto GCP são globalmente únicos e imutáveis — nunca hardcode um `project_id` dentro de um módulo; sempre receba por variável.

## Estrutura esperada em `tf-modules/gcp/`

```
tf-modules/
  gcp/
    vpc/
      main.tf
      variables.tf
      outputs.tf
      versions.tf
      CHANGELOG.md
    cloud-run/
      ...
```

Cada módulo é autocontido dentro da sua subpasta — sem depender de arquivos fora dela.
