output "public_subnet_ids" { value = [for s in aws_subnet.public : s.id] }
output "private_subnet_ids" { value = [for s in aws_subnet.private : s.id] }
output "web_sg_id" { value = aws_security_group.web.id }
output "alb_sg_id" { value = aws_security_group.alb.id }

output "vpc_id" { value = aws_vpc.this.id }