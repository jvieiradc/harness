# Terraform no Azure — especificidades

Esta referência cobre o que é específico do Azure dentro da convenção descrita no `SKILL.md`. Leia o `SKILL.md` primeiro — aqui só entra o que muda por causa do provider.

## Metadado de recurso

No Azure o mecanismo de metadado chama-se **tags**, como na AWS, mas o Azure limita o número de tags por recurso (histórico: 50) e não aceita alguns tipos de recurso com tags. Convenção mínima recomendada:

```hcl
tags = merge(
  var.tags,
  {
    ManagedBy = "terraform"
    Repo      = "iac-azure-<recurso>"
  }
)
```

`var.tags` deve ser uma variável exposta pelo módulo, nunca um valor fixo.

## Backend de state recomendado

Backend `azurerm`, usando uma storage account dedicada a state:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "" # via -backend-config
    storage_account_name = ""
    container_name       = ""
    key                  = "iac/<recurso>.tfstate"
  }
}
```

O backend `azurerm` usa lease de blob para locking — não precisa de uma tabela separada, mas a storage account/container precisam existir antes do `terraform init` (normalmente provisionados fora do próprio projeto que os usa, para evitar o problema de "quem versiona o state do state").

## `versions.tf`

```hcl
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
  features {}
}
```

O bloco `features {}` é obrigatório no provider `azurerm`, mesmo vazio.

## Particularidades de nomenclatura

- Muitos recursos Azure (storage account, key vault) têm nomes globalmente únicos e regras de charset restritas (sem hífen em storage account, por exemplo) — nunca hardcode um nome de recurso dentro de um módulo; sempre receba por variável e valide o padrão do recurso específico antes de aplicar `iac-azure-<recurso>` literalmente como nome de recurso.
- Recursos Azure vivem dentro de um Resource Group — módulos devem receber o nome do resource group por variável, não assumir ou criar um implicitamente, a menos que o módulo seja especificamente "criar resource group".

## Estrutura esperada em `tf-modules/azure/`

```
tf-modules/
  azure/
    vnet/
      main.tf
      variables.tf
      outputs.tf
      versions.tf
      CHANGELOG.md
    aks/
      ...
```

Cada módulo é autocontido dentro da sua subpasta — sem depender de arquivos fora dela.
