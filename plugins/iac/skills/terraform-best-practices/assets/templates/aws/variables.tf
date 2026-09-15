variable "name" {
  description = "Nome base do recurso. Usado para nomear o próprio recurso e para nomear sub-recursos (roles, policies, etc.)."
  type        = string
}

variable "region" {
  description = "Região AWS onde o recurso será provisionado."
  type        = string
}

variable "tags" {
  description = "Tags adicionais a aplicar sobre o recurso, além das tags padrão do módulo (ManagedBy, Repo)."
  type        = map(string)
  default     = {}
}

# Adicione aqui as variáveis específicas do recurso sendo criado.
# Prefira expor o máximo de parâmetros configuráveis com defaults sensatos,
# em vez de hardcodar valores no main.tf — é isso que torna o módulo reutilizável
# em outros projetos além deste.
