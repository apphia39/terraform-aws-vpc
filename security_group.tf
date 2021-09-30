
###################################
# Security Groups & Rules
###################################
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "ec2_sg"

  dynamic "ingress" {
    for_each = var.ec2_sg_port

    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "outbound rule for public security group"
    to_port     = 0
    from_port   = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "rds_sg"

  dynamic "ingress" {
    for_each = var.rds_sg_port

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}

resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "ecs_sg"

  dynamic "ingress" {
    for_each = var.ecs_sg_port

    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}