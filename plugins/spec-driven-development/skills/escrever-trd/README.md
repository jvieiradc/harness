# escrever-trd

**Categoria:** spec-driven-development

```bash
npx skills add jvieiradc/harness@escrever-trd --full-depth
```

## Resumo

Cria e mantém o **TRD** (Technical Requirements Document) em `docs/trd.md` — o documento técnico global do projeto: stack, arquitetura, requisitos não-funcionais, dependências externas, padrões e decisões globais. Também cria **ADRs** (Architecture Decision Records) em `docs/adrs/` no **Modo Decision**.

- Analisa o projeto automaticamente (`package.json`, `pyproject.toml`, `go.mod`, `docker-compose.yml`, configs de lint/teste...) antes de perguntar qualquer coisa
- Enriquece dependências externas detectadas com busca externa (rate limits, SLAs, quotas), tratando o resultado como sugestão com fonte, não fato
- Entrevista só o que sobrou depois de analisar e enriquecer — meta de ≤5 perguntas
- No **Modo Decision**, registra uma decisão técnica durável como ADR imutável, com supersedência explícita quando uma decisão substitui outra

<details>
<summary>Documentação completa</summary>

O fluxo completo está em [`SKILL.md`](./SKILL.md). A estrutura canônica está em [`references/template-trd.md`](./references/template-trd.md) (TRD) e [`references/template-adr.md`](./references/template-adr.md) (ADR).

### Pré-requisitos e configuração

- Nenhuma configuração. Os três modos são detectados sozinhos: **Criação** quando `docs/trd.md` não existe, **Edição** quando existe, e **Decision** por intenção explícita ("registra a decisão de…", "cria um ADR") — que sobrepõe a detecção automática e independe de o TRD existir.
- Um projeto de código para analisar. Quanto mais o projeto revelar, menor a entrevista. Se o projeto ainda não tem código (ex.: logo depois de uma sessão de `critical-analysis`), a skill parte do documento consolidado dessa sessão em vez de analisar arquivos.
- `docs/` e `docs/adrs/` são criados se não existirem.

### Estrutura do TRD gerado

| Seção | Conteúdo |
|---|---|
| **Stack** | Linguagem, runtime, framework, banco, ferramentas de build e pacotes |
| **Arquitetura** | Padrão arquitetural, estrutura de pastas, módulos principais |
| **Requisitos Não-Funcionais** | Performance, disponibilidade/SLA, escalabilidade, segurança, observabilidade — com valores mensuráveis |
| **Dependências Externas** | APIs de terceiros, serviços de infraestrutura e sistemas internos com SLA, rate limit ou contrato relevante |
| **Padrões** | Testes (framework + comando), estilo de código, error handling, logging, auth |
| **Decisões Globais** | Referências progressivas aos ADRs (título, data, status, link) |

### Dependências externas

- **WebSearch** (opcional) — enriquecer as dependências externas detectadas com constraints públicos.
- **MCPs de documentação** (opcional) — `context7` para bibliotecas e frameworks, ou MCPs específicos de serviços.

Nenhuma é obrigatória, mas sem elas o enriquecimento não acontece e a entrevista fica maior. Sistemas **internos** nunca são buscados — vêm só do usuário.

### Skills relacionadas

- **`escrever-prd`** — documenta a feature, não o projeto. Quando um input de PRD traz uma decisão arquitetural durável, ela é roteada para o Modo Decision desta skill. *(disponível neste harness)*
- **`critical-analysis`** — quando o projeto ainda não tem código, o documento consolidado de uma sessão com a lente de especificação de projeto de desenvolvimento serve como fonte pro TRD inicial. *(disponível neste harness, plugin `uso-geral`)*
- **`sdd-especificar`, `preparar-execucao`, `implementar-task`, `orquestrar-execucao`, `revisao-documento-tecnico`** — consomem o TRD como contexto técnico global nos passos seguintes do fluxo original. *(ainda não trazidas para este harness)*

### Posição no fluxo spec-driven

O TRD **não é um passo sequencial** do fluxo — é um artefato **global**, escrito uma vez e mantido, que alimentaria as demais skills sob demanda quando elas existirem neste harness:

```
escrever-prd (opcional) → [sdd-especificar] → [preparar-execucao] → [implementar-task] → [validar-implementacao]
                                     ▲
                            docs/trd.md + docs/adrs/
```

Os nós entre colchetes ainda não existem neste harness — por enquanto, TRD e ADR são consultados manualmente por você (ou por qualquer outra skill/tarefa que você rodar) quando for implementar.

### Exemplos de uso

```
Cria o TRD desse projeto

Documenta a stack e os padrões do projeto

O TRD está desatualizado — a stack mudou

Registra a decisão de usar Postgres em vez de Mongo

Cria um ADR para a estratégia de autenticação

Decidimos trocar o REST por gRPC — registra isso
```

### Como funciona (resumo)

**Criação** — análise automática → enriquecimento por busca externa → mini-entrevista (≤5 perguntas) → varredura de ADRs existentes → preview e gravação.

**Edição** — relê o TRD, re-analisa o projeto, classifica divergências (mudança não refletida / entrada que não se verifica mais / área ambígua / seção ausente), entrevista só o delta.

**Decision** — numera o ADR, gera draft-first com premissas marcadas, trata supersedência, grava e atualiza a seção Decisões Globais do TRD.

### O que é ADR (e o que não é)

Só decisão **durável, de blast radius amplo e cara de reverter** vira ADR: escolha de banco, estratégia de auth, padrão arquitetural, biblioteca estruturante, convenção de API. Decisão local a uma feature não é ADR.

### Limitações conhecidas

- **ADR `aceito` é imutável** — exceto o `status`, quando outro ADR o supersede.
- **Não cria ADR fora do Modo Decision.**
- **Não cria PRDs** (papel de `escrever-prd`) nem gera SPEC/PLAN/TASKS.
- **Cancelar o preview não tem efeito colateral** — nada é gravado.
- **NFRs raramente são inferíveis** — quase sempre viram pergunta.

</details>

## Estrutura

```
escrever-trd/
├── SKILL.md
└── references/
    ├── template-trd.md
    └── template-adr.md
```
