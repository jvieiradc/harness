module "recurso" {
  # Referência sempre por tag, nunca por branch — ver seção "Versionamento de módulo"
  # no SKILL.md da skill terraform-best-practices.
  source = "git::https://github.com/<org-ou-usuario>/tf-modules.git//aws/<modulo>?ref=aws/<modulo>/v1.0.0"

  name   = var.name
  region = var.region
  tags   = var.tags

  # Repasse aqui as demais variáveis específicas do módulo consumido.
}
