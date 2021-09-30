variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "cidr_private_subnet" {
  description = "CIDR block for the PRIVATE SUBNET"
  type        = list(any)
  default     = ["172.31.4.0/24", "172.31.5.0/24"]
}

variable "cidr_public_subnet" {
  description = "CIDR block for the PUBLIC SUBNET"
  type        = list(any)
  default     = ["172.31.100.0/24", "172.31.101.0/24"]
}

variable "cidr_igw" {
  description = "CIDR block for the INTERNET GATEWAY"
  type        = string
  default     = "0.0.0.0/0"
}

variable "availability_zone" {
  description = "availability zones"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}


####################################
# Security Groups
####################################
variable "ec2_sg_port" {
  description = "inbound rules of ec2 security group"
  default = [{
    port        = 22
    description = "inbound rules for port 22"
    },
    {
      port        = 8000
      description = "inbound rules for port 8000"
  }]
}

variable "rds_sg_port" {
  description = "inbound rules of rds security group"
  default = [{
    port        = 3306
    description = "inbound rules for port 3306"
  }]
}

variable "ecs_sg_port" {
  description = "inbound rules of ecs security group"
  default = [{
    port        = 22
    description = "inbound rules for port 22"
    },
    {
      port        = 443
      description = "inbound rules for port 443"
    },
    {
      port        = 5000
      description = "inbound rules for port 5000"
  }]
}
