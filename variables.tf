variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "project_name" { type = string }
variable "key_name" { type = string }
variable "cert_arn" { type = string }
variable "domain_name" { type = string } # e.g. "benkg312.com"
variable "zone_id" { type = string }     # Route 53 hosted-zone ID

# VPC/networking
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }

# Database
variable "db_name" {
  type    = string
  default = "myapp"
}
variable "db_username" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}

variable "azs" {
  description = "Availability Zones to spread subnets across"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}


# Input variables for project

# variable "azs" {
#   description = "List of availability zones"
#   type        = list(string)
# }
