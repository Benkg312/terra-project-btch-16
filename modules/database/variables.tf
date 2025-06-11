variable "project_name" { type = string }
variable "subnet_ids" { type = list(string) }
variable "db_username" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}
variable "db_name" { type = string }
variable "web_sg_id" {
  description = "Security group ID for the web layer"
  type        = string
}
variable "vpc_id" { type = string }