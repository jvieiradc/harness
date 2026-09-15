# harness

Coleção pessoal de skills e plugins para Claude Code, organizada por categoria em `plugins/<categoria>/skills/<skill>/`.

## Plugins

| Categoria | Skill | O que faz |
|---|---|---|
| `iac` | [`terraform-best-practices`](plugins/iac/skills/terraform-best-practices/SKILL.md) | Boas práticas de projeto Terraform — estrutura de repositório, nomenclatura, versionamento de módulos e gestão de ambiente, agnóstica de cloud provider (AWS, GCP, Azure). |

## Instalação

Cada skill pode ser copiada diretamente para `.claude/skills/<nome>/` de um projeto, ou instalada pelo mecanismo de sincronização de skills que você já usa (o mesmo que resolve `skillPath` num `skills-lock.json` apontando pra um repo GitHub). Para as skills deste repo, o `skillPath` é sempre `plugins/<categoria>/skills/<skill>/SKILL.md`.
