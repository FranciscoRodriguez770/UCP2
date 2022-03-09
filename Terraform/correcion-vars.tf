variable "location" {
  type         = string
  description  = "Región de Azure donde crearemos la infraestructura"
  default      = "West Europe"
}

variable "storage_account" {
  type         = string
  description  = "Nombre para la storage account"
  default      ="staccountcp2fr770"
} 

variable "public_key_path" {
  type         = string
  description  = "Ruta de la clave publica de acceso a las instancias"
  default      ="c:/Users/frodrigue53m/.ssh/k8s.pub"
}

variable "ssh_user" {
  type         = string
  description  ="Usuario para hacer ssh"
  default      = "adminUsername"
}
