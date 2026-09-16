# spec-driven-development

Fluxo spec-driven para software: escrever PRD e TRD/ADR.

Esta é uma importação parcial de um fluxo maior de terceiros — só as duas skills que geram documentação (PRD e TRD/ADR) estão neste plugin. As skills que consumiriam esses documentos para planejar e executar a implementação ainda não existem aqui (ver o `README.md` de cada skill abaixo para o que falta).

## Como instalar

Via Claude Code (plugin marketplace nativo):

```
/plugin marketplace add jvieiradc/harness
/plugin install spec-driven-development@jvieiradc-harness
```

Via `npx skills` (qualquer agente compatível com o formato aberto de Agent Skills):

```bash
npx skills add jvieiradc/harness/plugins/spec-driven-development/skills
```

## Skills

| Skill | O que faz |
|---|---|
| [`escrever-prd`](skills/escrever-prd/README.md) | Cria e edita PRDs (Product Requirements Documents) em `docs/prds/`, draft-first, com detecção de múltiplas features e grafo de dependência entre elas. |
| [`escrever-trd`](skills/escrever-trd/README.md) | Cria e mantém o TRD (`docs/trd.md`) e ADRs (`docs/adrs/`) do projeto — stack, arquitetura, NFRs, dependências externas e decisões técnicas duráveis. |

## Estrutura

```
spec-driven-development/
├── .claude-plugin/plugin.json
└── skills/
    ├── escrever-prd/
    └── escrever-trd/
```
