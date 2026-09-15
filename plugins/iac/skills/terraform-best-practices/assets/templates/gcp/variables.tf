variable "name" {
  description = "Nome base do recurso. Usado para nomear o próprio recurso e sub-recursos."
  type        = string
}

variable "project_id" {
  description = "ID do projeto GCP onde o recurso será provisionado."
  type        = string
}

variable "region" {
  description = "Região GCP onde o recurso será provisionado."
  type        = string
}

variable "labels" {
  description = "Labels adicionais a aplicar sobre o recurso, além das labels padrão do módulo (managed_by, repo). Chaves e valores só aceitam minúsculas, números, _ e -."
  type        = map(string)
  default     = {}
}

# Adicione aqui as variáveis específicas do recurso sendo criado.
# Prefira expor o máximo de parâmetros configuráveis com defaults sensatos,
# em vez de hardcodar valores no main.tf.
