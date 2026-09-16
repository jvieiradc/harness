# iac

Boas práticas de projeto Terraform, agnósticas de cloud provider (AWS, GCP, Azure).

## Como instalar

Via Claude Code (plugin marketplace nativo):

```
/plugin marketplace add jvieiradc/harness
/plugin install iac@jvieiradc-harness
```

Via `npx skills` (qualquer agente compatível com o formato aberto de Agent Skills):

```bash
npx skills add jvieiradc/harness/plugins/iac/skills
```

## Skills

| Skill | O que faz |
|---|---|
| [`terraform-best-practices`](skills/terraform-best-practices/README.md) | Cria e audita projetos Terraform seguindo a convenção pessoal do autor: repo central de módulos versionado por tag, repos de recurso nomeados `iac-{provider}-{recurso}`, ambiente via Terraform workspace nativo, e a regra de nunca rodar `apply`/`destroy` sem pedido explícito. |

## Estrutura

```
iac/
├── .claude-plugin/plugin.json
└── skills/
    └── terraform-best-practices/
```
