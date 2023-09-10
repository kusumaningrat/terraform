# VPC and Subnets Resource
vpc_names = ["vpc-a", "vpc-b"]
vpc_cidr_blocks = ["10.10.0.0/16", "10.20.0.0/16"]
subnet_names =[
    ["subnet-a-public", "subnet-a-private"],
    ["subnet-b-private"]
]
subnet_cidr_blocks = [
    ["10.10.1.0/24", "10.10.2.0/24"],
    ["10.20.1.0/24"],
]

# EC2 Instance
ami_id = "ami-0464f90f5928bccb8"
instance_type = "t2.micro"
key_name = "example"