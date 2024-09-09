variable "org_name" {
  type    = string
  default = "vinicius"
}


variable "state_bucket" {
  type        = string
  default     = "vinicius-state-bucket-tf"
  description = "Bucket com o estado"
}