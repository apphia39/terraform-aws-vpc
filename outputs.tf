output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.vpc.id
}

output "private_subnet_ids" {
  description = "private subnet id"
  value       = aws_subnet.private_subnet[*].id
}

output "public_subnet_ids" {
  description = "public subnet id"
  value       = aws_subnet.public_subnet[*].id
}

output "rds_sg_ids" {
  description = "rds security group id"
  value       = aws_security_group.rds_sg[*].id
}

output "ec2_sg_ids" {
  description = "ec2 security group id"
  value       = aws_security_group.ec2_sg[*].id
}

output "ecs_sg_ids" {
  description = "ecs security group id"
  value       = aws_security_group.ecs_sg[*].id
}