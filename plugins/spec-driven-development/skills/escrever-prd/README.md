# escrever-prd

**Categoria:** spec-driven-development

```bash
npx skills add jvieiradc/harness@escrever-prd --full-depth
```

## Resumo

Cria e edita PRDs (Product Requirements Documents) — o **documento humano** da feature, fonte de verdade da intenção de produto. Trabalha em modo **draft-first**: gera o documento completo imediatamente a partir do que você fornecer, marcando as premissas inferidas inline (`*(premissa — confirme ou corrija)*`) para revisão pontual, em vez de conduzir entrevista longa.

- Detecta quando o input cobre mais de uma feature e **propõe o split** em PRDs separados antes de gerar qualquer coisa
- Cada PRD é uma User Story estruturada (Rules + Edge cases), com critérios de aceite verificáveis e milestones como marcos de produto — sem piso mínimo de quantidade
- Mantém um grafo de dependência entre PRDs (`depends_on`), carregado sob demanda
- PRD com `status: concluido` é imutável — mudança de comportamento abre um PRD novo

<details>
<summary>Documentação completa</summary>

O fluxo completo está em [`SKILL.md`](./SKILL.md). A estrutura canônica do documento gerado está em [`references/template-prd.md`](./references/template-prd.md).

### Pré-requisitos e configuração

- Nenhuma configuração prévia. Basta uma descrição do que se quer construir (problema, ideia de solução, restrições conhecidas).
- **Modo edição** — a skill lê o PRD referenciado em `./docs/prds/`, verifica o `status` e preserva `prd_number`, nome do arquivo, `status` atual e os IDs de US e Milestone já atribuídos. USs novas recebem o próximo ID sequencial.
- **Local e nome do arquivo** — `./docs/prds/NNN-nome-em-kebab-case.md` (ex.: `003-autenticacao-oauth.md`). O número é sequencial, determinado varrendo o diretório, e gravado no campo `prd_number` do frontmatter.
- **Vocabulário de `status`** — `rascunho | pronto | em-progresso | concluido`.

### Dependências externas

Nenhuma. A skill trabalha só com arquivos markdown do próprio projeto.

### Skills relacionadas

- **`escrever-trd`** — dona do TRD e dos ADRs. Decisão arquitetural durável identificada no input do PRD é roteada para o Modo Decision dela (`docs/adrs/`); o PRD apenas referencia em §8. *(disponível neste harness)*
- **`critical-analysis`** — madurar a ideia antes de formalizar com `escrever-prd`. *(disponível neste harness, plugin `general-use`)*
- **`sdd-especificar`, `preparar-execucao`, `revisao-documento-tecnico`, `validar-implementacao`** — os passos seguintes do fluxo original (projetar o SPEC a partir do PRD, revisar antes de executar, fechar o ciclo promovendo o PRD a `concluido`). *(ainda não trazidas para este harness — por ora, a transição de `status` é manual)*

### Exemplos de uso

```
Quero criar um PRD para um sistema de autenticação com SSO

Cria um documento de requisitos para uma API de pagamentos

Preciso planejar uma feature de notificações em tempo real para o nosso app

Ajusta o PRD 003 para incluir o fluxo de convite por e-mail

Refinar o PRD de pagamentos: faltou o edge case de reembolso parcial

Esse PRD está grande demais? Avalia a granularidade e me diz se vale quebrar
```

### Como funciona (resumo)

1. **Modo** — detecta criação vs. edição (referência a um PRD existente = edição).
2. **Análise de escopo** — detecta múltiplas features e **propõe o split** ("Detectei 3 features… Começamos pelo PRD-A?"), aguardando confirmação. Só interrompe com pergunta quando há lacuna **bloqueante**; o resto é inferido e marcado.
3. **Draft** — gera o PRD completo de uma vez, com as premissas marcadas inline.
4. **Dependências** — varre `./docs/prds/`, avalia dependência real e específica com cada PRD existente e preenche `depends_on`.
5. **Refinamento** — aplica as correções até a aprovação.
6. **Salvar** — numera, nomeia e grava.
7. **Continuidade multi-PRD** — se havia split pendente, oferece seguir para o próximo PRD.

### Limitações conhecidas

- **PRDs com `status: concluido` são imutáveis** — mudança de comportamento posterior abre um PRD novo.
- **Não transiciona `status`** automaticamente — as transições para `pronto`, `em-progresso` e `concluido` dependiam, no harness de origem, de skills que ainda não existem aqui. Por ora, mude o campo manualmente.
- **Não cobre o técnico** — stack, arquitetura e NFR global ficam no TRD; decisão arquitetural durável vira ADR.
- **Não decompõe em tasks** — milestone é marco de produto, não fatia de execução.
- Critérios de sucesso vagos ("deve funcionar bem") são reformulados até ficarem verificáveis, ou marcados como premissa.

</details>

## Estrutura

```
escrever-prd/
├── SKILL.md
├── evals/
│   └── evals.json
└── references/
    └── template-prd.md
```
