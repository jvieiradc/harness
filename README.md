# harness

Marketplace pessoal de plugins para Claude Code — e para qualquer outro agente compatível com o formato aberto de Agent Skills (via [`npx skills`](https://github.com/vercel-labs/skills)). Reúne skills técnicas reutilizáveis entre projetos e equipe.

## Como instalar

Via `npx skills` (skills aninhadas em `plugins/*/skills/*` → `--full-depth`):

```bash
# Instalar todas as skills
npx skills add jvieiradc/harness --full-depth

# Instalar as skills de um plugin
npx skills add jvieiradc/harness/plugins/iac/skills

# Instalar uma skill específica
npx skills add jvieiradc/harness@terraform-best-practices --full-depth
```

`npx skills` não é exclusivo do Claude Code — na data em que este README foi escrito, o instalador declarava suporte a mais de 75 agentes diferentes (Claude Code, Cursor, OpenCode, Codex, entre outros), via a flag `-a/--agent`. Como `SKILL.md` é só markdown com frontmatter, qualquer agente que leia arquivo texto pode se beneficiar do conteúdo, mesmo sem o instalador.

Este repositório também segue o formato oficial de plugin marketplace do Claude Code (`.claude-plugin/marketplace.json`), então funciona com o fluxo nativo `/plugin marketplace add jvieiradc/harness` — consulte `/plugin help` na sua versão do Claude Code para a sintaxe exata de instalação a partir daí.

## Plugins

| Plugin | Descrição |
|---|---|
| `iac` | Boas práticas de projeto Terraform — estrutura de repositório, nomenclatura, versionamento de módulos e gestão de ambiente, agnóstica de cloud provider (AWS, GCP, Azure) |

### Skills por plugin

| Plugin | Skill | O que faz |
|---|---|---|
| `iac` | [`terraform-best-practices`](plugins/iac/skills/terraform-best-practices/SKILL.md) | Cria e audita projetos Terraform seguindo a convenção pessoal do autor: repo central de módulos versionado por tag, repos de recurso nomeados `iac-{provider}-{recurso}`, ambiente via Terraform workspace nativo, e a regra de nunca rodar `apply`/`destroy` sem pedido explícito. |

## Estrutura

```
harness/
├── .claude-plugin/marketplace.json
├── plugins/<dominio>/
│   ├── .claude-plugin/plugin.json
│   └── skills/<skill>/
│       ├── SKILL.md
│       ├── references/    (carregado sob demanda)
│       └── assets/        (templates usados na geração de saída)
```

Novas skills entram como uma nova subpasta em `plugins/<dominio>/skills/`, ou um novo `<dominio>` quando o assunto não se encaixa em nenhum plugin existente.
