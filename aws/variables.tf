variable "access_key" {
  type = string
  default = "<your_access_key>"
  description = "AWS Access Key"
}

variable "secret_key" {
  type = string
  default = "<your_secret_key>"
  description = "AWS Secret Key"
}

variable "region-name" {
    type = string
    default = "<your_region_name>"
    description = "AWS Region"
}

variable "ami_id" {
    type = string
    default = "<your_image_id>"
    description = "value of ami_id"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
    description = "value of instance_type"
}

variable "subnet_id" {
    type = string
    default = "<your_subnet_id>"
    description = "value of subnet_id"
}

variable "security_group_id" {
    type = map(list(string))
    default = {
        "mysec-group" = ["your_security_group_id"]
    }
    description = "value of security_group_id"
}

variable "key_pairs" {
  type = string
  default = "mykey"
  description = "value of key_pairs"
}

