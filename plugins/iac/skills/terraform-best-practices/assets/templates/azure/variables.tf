variable "name" {
  description = "Nome base do recurso. Usado para nomear o próprio recurso e sub-recursos."
  type        = string
}

variable "resource_group_name" {
  description = "Nome do Resource Group onde o recurso será provisionado. Não crie um Resource Group implicitamente dentro do módulo — receba por variável."
  type        = string
}

variable "location" {
  description = "Região Azure onde o recurso será provisionado."
  type        = string
}

variable "tags" {
  description = "Tags adicionais a aplicar sobre o recurso, além das tags padrão do módulo (ManagedBy, Repo)."
  type        = map(string)
  default     = {}
}

# Adicione aqui as variáveis específicas do recurso sendo criado.
# Prefira expor o máximo de parâmetros configuráveis com defaults sensatos,
# em vez de hardcodar valores no main.tf.
