# terraform-best-practices

**Categoria:** iac

```bash
npx skills add jvieiradc/harness@terraform-best-practices --full-depth
```

## Resumo

Define e aplica boas práticas de projeto Terraform — estrutura de repositório, nomenclatura, versionamento de módulos e gestão de ambiente — de forma agnóstica de cloud provider (AWS, GCP, Azure).

- Cria projetos novos seguindo a convenção `iac-{provider}-{recurso}`, consumindo módulos versionados do repo central `tf-modules`
- Audita projetos Terraform existentes contra um checklist de boas práticas, sem depender de `tflint`/`checkov`
- Traz referência e templates de scaffolding próprios para AWS, GCP e Azure, carregados sob demanda
- Nunca executa `terraform apply` ou `terraform destroy` por conta própria — só mediante pedido explícito na interação

<details>
<summary>Documentação completa</summary>

O núcleo da skill — convenções, regra de segurança e os dois fluxos de uso (criação e auditoria) — está em [`SKILL.md`](./SKILL.md).

Especificidades de cada provider (terminologia de metadado, backend de state recomendado, particularidades de nomenclatura) estão em `references/`:

- [`references/aws.md`](./references/aws.md)
- [`references/gcp.md`](./references/gcp.md)
- [`references/azure.md`](./references/azure.md)

Esqueletos de arquivo prontos para começar um projeto novo, um por provider, estão em `assets/templates/{aws,gcp,azure}/`.

</details>

## Estrutura

```
terraform-best-practices/
├── SKILL.md
├── references/
│   ├── aws.md
│   ├── gcp.md
│   └── azure.md
└── assets/templates/
    ├── aws/
    ├── gcp/
    └── azure/
```
