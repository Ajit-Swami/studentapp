variable "eks_cluster_name" {
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

variable "eks_cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  type        = string
}

variable "eks_node_group_role_arn" {
  description = "IAM role ARN for EKS node group"
  type        = string
}