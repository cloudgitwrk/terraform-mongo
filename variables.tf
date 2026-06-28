variable "public_key" {
  type = string
}

variable "private_key" {
  type      = string
  sensitive = true
}

variable "org_id" {
  type = string
}
