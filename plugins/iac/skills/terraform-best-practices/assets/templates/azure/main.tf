module "recurso" {
  # Referência sempre por tag, nunca por branch — ver seção "Versionamento de módulo"
  # no SKILL.md da skill terraform-best-practices.
  source = "git::https://github.com/<org-ou-usuario>/tf-modules.git//azure/<modulo>?ref=azure/<modulo>/v1.0.0"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  # Repasse aqui as demais variáveis específicas do módulo consumido.
}
