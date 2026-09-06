output "aws_vpc_id" {
  description = "The ID of custom VPC"
  value       = aws_vpc.new_vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of public subnets"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "The IDs of private subnets"
  value       = aws_subnet.private_subnet[*].id
}

output "igw_id" {
  description = "The ID of Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "nat_id" {
  description = "ID of NAT Gatway"
  value       = aws_nat_gateway.nat_gw.id
}

output "public_route_table_id" {
  description = "The ID of public route table"
  value       = aws_route_table.public_route_table.id
}

output "private_route_table_id" {
  description = "The ID of private route table"
  value       = aws_route_table.private_route_table.id
}

output "security_group_id" {
  description = "The ID of security group"
  value       = aws_security_group.web_sg.id
}

output "security_group_name" {
  description = "The name of security group"
  value       = aws_security_group.web_sg.name
}

output "s3_bucket_name" {
  description = "The name of S3 bucket"
  value       = aws_s3_bucket.s3_bucket.bucket
}