variable "project_name" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }

# Derive AZs directly from input (us-east-1a, us-east-1b)
# locals { azs = ["us-east-1a", "us-east-1b"] }

variable "azs" {
    description = "Availability Zones to spread subnets across"
    type        = list(string)
    default     = ["us-east-1a", "us-east-1b"]
}
