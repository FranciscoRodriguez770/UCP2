variable "workers" {
    type        = list(string)
    description = "Máquinas virtuales a crear"
    default     = ["k8snode01","k8snode02"]
}

variable "master" {
    type        = string
    description = "Máquinas virtuales a crear"
    default     = "k8smaster"
}

variable "vm_size_workers" {
  type = string
  description = "Tamaño de las maquina virtuales workers"
  default ="Standard_D1_v2"
}

variable "vm_size_master" {
  type = string
  description = "Tamaño de la maquina master"
  default ="Standard_D2_v2"
}
