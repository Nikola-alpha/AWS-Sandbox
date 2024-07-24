variable "VPC_region" {
  description = "Adding non-default VPC in Singapore Region"
  default     = "ap-southeast-1"
}

variable "AZ1-public-subnet_name" {
  description = "Adding non-default VPC in Singapore Region"
  default     = "public-subnet_1a"
}
variable "AZ2-public-subnet_name" {
  description = "Adding non-default VPC in Singapore Region"
  default     = "public-subnet_1b"
}
variable "AZ1-private-subnet_name" {
  description = "Adding non-default VPC in Singapore Region"
  default     = "private-subnet_1a"
}
variable "AZ2-private-subnet_name" {
  description = "Adding non-default VPC in Singapore Region"
  default     = "private-subnet_1b"
}
variable "instance-ami" {
  description = "ami-for-ec2"
  default     = "ami-012c2e8e24e2ae21d"
}
variable "instance-type" {

}
variable "VPC_name" {

}
