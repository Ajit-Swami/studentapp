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