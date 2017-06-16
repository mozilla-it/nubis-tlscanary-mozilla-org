variable "account" {
  default = ""
}

variable "region" {
  default = "us-west-2"
}

variable "environment" {
  default = "stage"
}

variable "service_name" {
  default = "tlscanary"
}

variable "ami" {}

variable "ssh_key_file" {
  default = ""
}

variable "ssh_key_name" {
  default = ""
}

variable "root_storage_size" {
  default = "16"
}
