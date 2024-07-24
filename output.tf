output "VPC_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}
output "VPC_cidr" {
  description = "cidr of the VPC"
  value       = aws_vpc.main.cidr_block
}
output "Pub-sub-1a-id" {
  description = "Pub-sub-1a-id"
  value       = aws_subnet.public-subnet-1a.id
}
output "Pub-sub-1b-id" {
  description = "Pub-sub-1b-id"
  value       = aws_subnet.public-subnet-1b.id
}
output "priv-sub-1a-id" {
  description = "priv-sub-1a-id"
  value       = aws_subnet.private-subnet-1a.id
}
output "Priv-sub-1b-id" {
  description = "Priv-sub-1b-id"
  value       = aws_subnet.private-subnet-1b.id
}
output "NATGW-id" {
  description = "NATGW-id"
  value       = aws_nat_gateway.Alpha-natgw.id
}
output "bastion-host-eip" {
  description = "bastion-host-eip"
  value       = aws_eip.bastion_eip.public_ip
}
output "myprivate-instance-id" {
  description = "myprivate_instance-private-ip"
  value       = aws_instance.myprivate_instance.private_ip
}
