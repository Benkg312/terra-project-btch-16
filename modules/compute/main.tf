data "aws_key_pair" "this" { key_name = var.key_name }

resource "aws_instance" "web" {
    # the key will be the index, not the subnet ID itself
  for_each               = { for idx, subnet in var.subnet_ids : idx => subnet }
  
  subnet_id              = each.value
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.this.key_name
  vpc_security_group_ids = [var.web_sg_id]
  user_data              = base64encode(var.user_data_extra)
  
  tags = {
    Name = "${var.project_name}-web-${each.key}"
  }
}

