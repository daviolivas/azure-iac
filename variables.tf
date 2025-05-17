variable "resource_group_name" {
  default     = "machines"
}

variable "machine_size" {
  default     = "Standard_B1ls_v1"
}

variable "class_c_subnet_id" {
  default     = "/subscriptions/c4c24a8e-87b6-4192-a023-d73a898fca7e/resourceGroups/networks/providers/Microsoft.Network/virtualNetworks/vn-sandbox/subnets/first-subnet"
}