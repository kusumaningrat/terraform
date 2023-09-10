variable "ami_id" {
    description = "value of ami_id"
    type = string
}

variable "instance_type" {
    description = "value of instance_type"
    type = string
}

variable "key_name" {
  description = "ssh key name"
  type = string
}

variable "vpc_ids" {
  description = "List of VPC IDs"
  type        = list(string)
}

variable "subnet_a_ids" {
  description = "List of subnet A IDs"
  type        = list(string)
}

variable "subnet_b_ids" {
  description = "List of subnet B IDs"
  type        = list(string)
}

variable "subnet_cidr_blocks" {
  description = "List of Subnet CIDR Blocks"
  type = list(list(string))
}
