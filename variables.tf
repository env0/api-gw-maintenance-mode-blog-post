# Variables
variable "region" {
  type = string
  default = "us-east-1"
}

variable "accountId" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "route53_suffix_domain_name" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "maintenance_mode" {
  type = bool
  default = false
}
