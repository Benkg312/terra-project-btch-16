module "network" {
  source               = "./modules/network"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

module "compute" {
  source          = "./modules/compute"
  project_name    = var.project_name
  subnet_ids      = module.network.public_subnet_ids
  key_name        = var.key_name
  ami_id          = data.aws_ami.al2.id
  web_sg_id       = module.network.web_sg_id
  user_data_extra = <<-EOF
#!/bin/bash
set -e

yum -y update
yum -y install httpd

# itself index.html
cat >/var/www/html/index.html <<'HTML'
<html><body><h1>Hello from Ben Deployed via Terraform in $(hostname)</h1></body></html>
HTML

systemctl enable httpd
systemctl restart httpd
EOF
}

# set -e , yum update -y
#   cat <<'HTML' >/var/www/html/index.html
#   <html><body><h1>Deployed via Terraform in $(hostname)</h1></body></html>
#   HTML
# EOF

module "alb" {
  source              = "./modules/alb"
  project_name        = var.project_name
  subnet_ids          = module.network.public_subnet_ids
  alb_sg_id           = module.network.alb_sg_id
  target_instance_ids = module.compute.instance_ids
  vpc_id              = module.network.vpc_id
  cert_arn            = var.cert_arn
}

module "database" {
  source       = "./modules/database"
  project_name = var.project_name
  subnet_ids   = module.network.private_subnet_ids
  web_sg_id    = module.network.web_sg_id
  vpc_id       = module.network.vpc_id
  db_username  = var.db_username
  db_password  = var.db_password
  db_name      = var.db_name
}

module "dns" {
  source       = "./modules/dns"
  domain_name  = var.domain_name
  zone_id      = var.zone_id
  alb_dns_name = module.alb.dns_name
  alb_zone_id  = module.alb.zone_id
}

# Pull the latest Amazon Linux 2 AMI automatically
data "aws_ami" "al2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
}
