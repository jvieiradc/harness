# general-use

Skills de uso geral, não específicas de um domínio técnico — maturação de ideias e análise crítica.

## Como instalar

Via Claude Code (plugin marketplace nativo):

```
/plugin marketplace add jvieiradc/harness
/plugin install general-use@jvieiradc-harness
```

Via `npx skills` (qualquer agente compatível com o formato aberto de Agent Skills):

```bash
npx skills add jvieiradc/harness/plugins/general-use/skills
```

## Skills

| Skill | O que faz |
|---|---|
| [`critical-analysis`](skills/critical-analysis/README.md) | Modo de maturação de ideias com ceticismo por padrão — questiona premissas, aponta trade-offs e riscos, pergunta em prosa (não por menu), e recomenda a opção mais simples quando duas empatam em qualidade. |

## Estrutura

```
general-use/
├── .claude-plugin/plugin.json
└── skills/
    └── critical-analysis/
```
