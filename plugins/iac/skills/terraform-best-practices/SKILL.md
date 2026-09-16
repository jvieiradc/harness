---
name: terraform-best-practices
description: >-
  Define e aplica as boas práticas de projeto Terraform do usuário — estrutura de repositório, nomenclatura, versionamento de módulos e gestão de ambiente — de forma agnóstica de cloud provider (AWS, GCP, Azure). Use esta skill sempre que o usuário pedir para criar um projeto/recurso Terraform novo (ex.: "cria um projeto terraform para uma VPC na AWS", "preciso de um repo iac para um Cloud Run", "monta a estrutura desse recurso GCP"), para revisar ou auditar um projeto Terraform existente contra boas práticas, ou mencionar termos como "tf-modules", "iac-aws-*"/"iac-gcp-*"/"iac-azure-*", estrutura de projeto Terraform, versionamento de módulo, ou gestão de ambiente (dev/stage/prod) em Terraform — mesmo que o usuário não diga explicitamente "boas práticas". Esta skill nunca executa `terraform apply` ou `terraform destroy` por conta própria.
---

# Terraform Best Practices

Convenção de projeto Terraform validada em uso real, agnóstica de cloud provider. O núcleo aqui é o que vale para AWS, GCP e Azure igualmente; o que muda por provider está em `references/`.

## Regra de segurança — vale para tudo que segue

**Nunca execute `terraform apply` ou `terraform destroy`** como parte de criar ou auditar um projeto, mesmo que pareça o próximo passo óbvio do fluxo. Só rode um desses dois comandos quando o usuário pedir isso explicitamente, na mensagem em que está pedindo — não porque um passo anterior "levava a isso" ou porque terminar o fluxo "exigiria" aplicar.

Por quê: um agente que aplica ou destrói infraestrutura por iniciativa própria pode causar dano real e irreversível a partir de uma leitura otimista do pedido do usuário. `terraform plan` e `terraform validate` são seguros (não alteram nada) e ficam livres para uso sempre que ajudarem a verificar o trabalho.

## Visão geral da convenção

- **Módulos vivem num repo central `tf-modules`**, organizado em uma pasta por provider (`aws/`, `gcp/`, `azure/`), com cada módulo em sua própria subpasta dentro da pasta do provider.
- **Cada recurso de infraestrutura vira seu próprio repo**, nomeado `iac-{provider}-{nome-do-recurso}` (ex.: `iac-aws-vpc`, `iac-gcp-cloud-run`, `iac-azure-aks`). Esse repo nunca duplica lógica de módulo — ele só consome módulos do `tf-modules`.
- **Módulos são consumidos por referência git versionada**, nunca por path local nem por branch:
  ```hcl
  source = "git::https://github.com/<org-ou-usuario>/tf-modules.git//aws/vpc?ref=aws/vpc/v1.2.0"
  ```
- **Módulos expõem o máximo de variáveis possível**, com defaults sensatos. O objetivo é reuso: quem consome o módulo deve conseguir adaptar o comportamento por variável em vez de fazer fork ou editar o módulo diretamente.

Essas quatro regras não mudam por cloud provider — o que muda é a terminologia (tags vs. labels), o backend de state e as particularidades de cada provider, que estão em `references/{provider}.md`.

## Versionamento de módulo

Tag por módulo, não tag única do repo `tf-modules` inteiro: `{provider}/{modulo}/vMAJOR.MINOR.PATCH` (ex.: `gcp/cloud-run/v2.1.0`).

Importante entender a mecânica real antes de aplicar isso: o `ref=` do Terraform sempre resolve para um commit do repositório **inteiro** — não existe tag nativa "por subpasta". A convenção de nome (`{provider}/{modulo}/vX.Y.Z`) é uma disciplina de processo, não um recurso do Terraform. Ela só funciona se a tag for criada logo depois de mesclar uma mudança naquele módulo específico, antes de acumular mudanças de outros módulos no mesmo commit. Se isso não for respeitado, um consumidor que atualizar para uma tag mais nova de "seu" módulo pode acabar puxando também mudanças de outro módulo que aconteceram de estar no mesmo commit.

Ao criar ou revisar um módulo, verifique se ele tem um `CHANGELOG.md` próprio na sua subpasta — isso ajuda a saber o que mudou entre tags sem depender de `git log` no repo inteiro.

## Gestão de ambiente (dev/stage/prod)

Padrão: **Terraform workspace nativo** (`terraform workspace new dev`, `terraform workspace select prod`). O backend isola o state automaticamente por workspace, e o código usa `terraform.workspace` quando o comportamento precisa variar por ambiente. Um único conjunto de arquivos `.tf` serve todos os ambientes.

**Exceção obrigatória**: se, ao criar ou auditar um projeto, você encontrar um padrão de diretório por ambiente já em uso (`envs/dev/`, `envs/prod/`, ou similar), **não migre nem normalize por conta própria**. Pergunte ao usuário se ele quer manter esse padrão ou migrar para workspace, mostrando os dois lados:

| | Workspace nativo | Diretório por ambiente |
|---|---|---|
| A favor | Sem duplicação de `.tf`; comando padrão do Terraform; backend isola state sozinho | Ambientes podem divergir estruturalmente sem condicional; fica visualmente explícito em qual ambiente se está operando |
| Contra | Risco de rodar comando no workspace errado sem perceber; tudo fica em `if`/lookup quando ambientes divergem muito | Duplicação de código entre pastas (a menos que tudo vire módulo); mais arquivo pra manter sincronizado |

Motivo da exceção: mudar a forma como um projeto já em produção isola seus ambientes é uma decisão estrutural, potencialmente arriscada de reverter — não é algo que deva acontecer como efeito colateral de uma auditoria.

## Fluxo 1 — Criar um projeto novo

1. Identifique o provider (AWS, GCP ou Azure) e o recurso que o usuário quer provisionar. Se não estiver claro, pergunte.
2. Leia `references/{provider}.md` para pegar as especificidades daquele provider (terminologia de metadado, backend recomendado, particularidades do provider Terraform).
3. Defina o nome do repo como `iac-{provider}-{recurso}` (kebab-case).
4. Copie o esqueleto de `assets/templates/{provider}/` como ponto de partida (`main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`, `backend.tf`, `README.md`), adaptando ao recurso específico.
5. Aponte o `source` do módulo em `main.tf` para `tf-modules/{provider}/{recurso}`, com uma tag concreta (peça ao usuário qual versão do módulo usar, ou assuma a mais recente conhecida e avise que confirmou essa suposição).
6. Rode `terraform init` e `terraform validate` para conferir que a estrutura é válida. **Não rode `plan` contra um backend real sem que as credenciais/backend estejam de fato configurados pelo usuário**, e nunca rode `apply`.

## Fluxo 2 — Auditar um projeto existente

Percorra este checklist contra o repo apontado pelo usuário e devolva um relatório dizendo o que está conforme, o que diverge, e o que é preciso decidir com o usuário (não decida sozinho os itens marcados com ⚠️):

1. **Nome do repo** segue `iac-{provider}-{recurso}`?
2. **Consumo de módulo**: o `source` aponta para o `tf-modules` central, via `ref=` de tag (nunca branch, nunca path local)? A tag segue `{provider}/{modulo}/vX.Y.Z`?
3. **Variáveis**: o projeto expõe parâmetros configuráveis em vez de valores fixos no código onde faria sentido variar?
4. ⚠️ **Ambiente**: usa workspace nativo? Se usa diretório por ambiente, siga a regra da seção "Gestão de ambiente" acima — pergunte antes de sugerir mudança.
5. **Backend remoto**: está configurado com locking (ver `references/{provider}.md` para o padrão daquele provider)?
6. **`versions.tf`**: `required_version` e `required_providers` presentes, com fonte e constraint de versão explícitos (não implícito)?
7. **Metadado obrigatório**: tags/labels aplicados conforme a convenção do provider (ver referência)?

Este checklist é deliberadamente independente de ferramentas como `tflint` ou `checkov` — não as invoque como parte desta auditoria; o objetivo aqui é verificar a convenção de projeto, não substituir lint estático.

## Referências por provider

| Provider | Arquivo | Quando ler |
|---|---|---|
| AWS | `references/aws.md` | Sempre que o recurso for AWS |
| GCP | `references/gcp.md` | Sempre que o recurso for GCP |
| Azure | `references/azure.md` | Sempre que o recurso for Azure |

Carregue apenas a referência do provider relevante para a tarefa atual — não é necessário ler as três para atender um pedido de um único provider.
