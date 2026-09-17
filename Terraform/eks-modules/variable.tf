variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}


variable "eks_cluster_endpoint_private" {
  description = "Whether the EKS cluster has private endpoint"
  type        = bool
  default     = true
}

variable "eks_cluster_endpoint_public" {
  description = "Whether the EKS cluster has public endpoint"
  type        = bool
  default     = true
}

variable "eks_cluster_endpoint_public_access_cidrs" {
  description = "CIDR blocks that can access the EKS cluster public endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "eks_cluster_node_group_subnets" {
  description = "Subnet IDs for the EKS node group"
  type        = list(string)
  default     = []
}

variable "eks_cluster_node_group_desired_size" {
  description = "Desired number of nodes in the node group"
  type        = number
  default     = 2
}

variable "eks_cluster_node_group_max_size" {
  description = "Maximum number of nodes in the node group"
  type        = number
  default     = 3
}

variable "eks_cluster_node_group_min_size" {
  description = "Minimum number of nodes in the node group"
  type        = number
  default     = 1
}

variable "eks_cluster_node_group_instance_types" {
  description = "Instance types for the node group"
  type        = list(string)
  default     = ["t3.micro"]
}

variable "eks_cluster_node_group_capacity_type" {
  description = "Capacity type for the node group (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "eks_cluster_node_group_labels" {
  description = "Labels to apply to the node group"
  type        = map(string)
  default     = {}
}

variable "eks_cluster_role_name" {
  description = "Name of the IAM role for EKS cluster"
  type        = string
  default     = "eks-cluster-role"
}

variable "eks_node_group_role_name" {
  description = "Name of the IAM role for EKS node group"
  type        = string
  default     = "eks-node-group-role"
}

variable "instance_profile_name" {
  description = "Name of the instance profile"
  type        = string
  default     = "eks-instance-profile"
}

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

variable "private_subnet_az" {
  description = "Availability zone for private subnet"
  type        = string
  default     = "us-west-2b"
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