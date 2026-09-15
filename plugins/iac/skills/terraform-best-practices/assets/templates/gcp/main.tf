module "recurso" {
  # Referência sempre por tag, nunca por branch — ver seção "Versionamento de módulo"
  # no SKILL.md da skill terraform-best-practices.
  source = "git::https://github.com/<org-ou-usuario>/tf-modules.git//gcp/<modulo>?ref=gcp/<modulo>/v1.0.0"

  name       = var.name
  project_id = var.project_id
  region     = var.region
  labels     = var.labels

  # Repasse aqui as demais variáveis específicas do módulo consumido.
}
