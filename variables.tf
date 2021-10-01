variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  default     = ""
}

variable "subnet_num" {
  description = "Number of the subnets"
  type        = string
  default     = ""
}

variable "public_name" {
  description = "Name for the public subnet"
  type        = string
  default     = ""
}

variable "private_name" {
  description = "Name for the private subnet"
  type        = string
  default     = ""
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the PRIVATE SUBNET"
  type        = list(string)
  default     = []
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the PUBLIC SUBNET"
  type        = list(string)
  default     = []
}

variable "igw_name" {
  description = "Name for the internet gateway"
  type        = string
  default     = ""
}

variable "igw_cidr" {
  description = "CIDR block for the INTERNET GATEWAY"
  type        = string
  default     = ""
}

variable "subnet_az" {
  description = "availability zones"
  default     = []
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
