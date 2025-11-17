variable "resource_group_name" {
  default     = "machines"
}

variable "machine_size" {
  default     = "Standard_B1ls_v1"
}

variable "class_c_subnet_id" {
  default     = "/subscriptions/c4c24a8e-87b6-4192-a023-d73a898fca7e/resourceGroups/networks/providers/Microsoft.Network/virtualNetworks/vn-sandbox/subnets/first-subnet"
}

# Variável para o Client ID (Application ID)
variable "arm_client_id" {
  description = "The Azure Client ID (Application ID) for the Service Principal."
  type        = string
  sensitive   = true # Recomendado para não mostrar o valor no output do plan
}

# Variável para o Client Secret (Chave/Senha)
variable "arm_client_secret" {
  description = "The Azure Client Secret (password) for the Service Principal."
  type        = string
  sensitive   = true
}

# Variável para o Tenant ID (Directory ID)
variable "arm_tenant_id" {
  description = "The Azure Tenant ID (Directory ID)."
  type        = string
  sensitive   = true
}

# Variável para o Subscription ID
variable "arm_subscription_id" {
  description = "The Azure Subscription ID."
  type        = string
  sensitive   = true
}