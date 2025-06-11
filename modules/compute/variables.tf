variable "project_name" { type = string }
variable "subnet_ids" { type = list(string) }
variable "key_name" { type = string }
variable "ami_id" { type = string }
variable "web_sg_id" { type = string }
variable "user_data_extra" { type = string }
