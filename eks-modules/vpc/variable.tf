variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.10.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.20.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a"]
}

variable "security_group_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for EKS"
}

variable "private_subnet_association" {
  description = "Whether to associate private subnet"
  type        = bool
  default     = true
}

variable "private_subnet_az" {
  description = "Availability zone for private subnet"
  type        = string
  default     = "us-west-2b"
}

variable "private_route_table" {
  description = "Whether to create private route table"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "nat_gateway" {
  description = "Whether to create NAT gateway"
  type        = bool
  default     = true
}

variable "public_route_table" {
  description = "Whether to create public route table"
  type        = bool
  default     = true
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "eks-project"
}