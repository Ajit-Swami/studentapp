resource "aws_eks_cluster" "this" {
  name = var.eks_cluster_name
  role_arn = var.eks_cluster_role_arn
  
  vpc_config {
    endpoint_public_access = var.eks_cluster_endpoint_public
    endpoint_private_access = var.eks_cluster_endpoint_private
    public_access_cidrs = var.eks_cluster_endpoint_public_access_cidrs
    subnet_ids = var.eks_cluster_node_group_subnets
  }
  
}

resource "aws_eks_node_group" "this" {
  cluster_name = aws_eks_cluster.this.name
  node_group_name = "default"
  node_role_arn = var.eks_node_group_role_arn
  subnet_ids = var.eks_cluster_node_group_subnets
  scaling_config {
    desired_size = var.eks_cluster_node_group_desired_size
    max_size = var.eks_cluster_node_group_max_size
    min_size = var.eks_cluster_node_group_min_size
  }
  instance_types = var.eks_cluster_node_group_instance_types
  capacity_type = var.eks_cluster_node_group_capacity_type
  labels = var.eks_cluster_node_group_labels
}
