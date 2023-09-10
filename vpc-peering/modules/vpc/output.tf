output "vpc_ids" {
  description = "List of VPC IDs"
  value       = aws_vpc.myvpc[*].id
}

output "subnet_a_ids" {
  description = "List of subnet A IDs"
  value       = aws_subnet.subnet-a[*].id
}

output "subnet_b_ids" {
  description = "List of subnet B IDs"
  value       = aws_subnet.subnet-b[*].id
}