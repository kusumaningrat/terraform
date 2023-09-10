# VPC Names
variable "vpc_names" {
  description = "List of VPC Names"
  type = list(string) 
}

# VPC CIDR Block
variable "vpc_cidr_blocks" {
  description = "List of VPC CIDR Blocks"
  type = list(string) 
}

# Subnet Names
variable "subnet_names" {
  description = "List of Subnet Names"
  type = list(list(string))
}

# Subnet CIDR Block
variable "subnet_cidr_blocks" {
  description = "List of Subnet CIDR Blocks"
  type = list(list(string))
}