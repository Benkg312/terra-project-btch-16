variable "project_name" { type = string }
variable "subnet_ids" { type = list(string) }
variable "alb_sg_id" { type = string }
variable "target_instance_ids" { type = list(string) }
variable "cert_arn" { type = string }

variable "vpc_id" { type = string }
