module "vpc" {
  source = "./vpc"
  
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  availability_zones = var.availability_zones
  security_group_description = var.security_group_description
  private_subnet_association = true
  private_subnet_az = var.private_subnet_az
  private_route_table = true
  tags = var.tags
  nat_gateway = var.nat_gateway
  public_route_table = var.public_route_table
  project_name = var.project_name
}

module "iam" {
  source = "./iam"
  
  eks_cluster_role_name = var.eks_cluster_role_name
  eks_node_group_role_name = var.eks_node_group_role_name
  instance_profile_name = var.instance_profile_name
}

module "eks" {
  source = "./eks"

  eks_cluster_name = var.cluster_name
  eks_cluster_endpoint_private = var.eks_cluster_endpoint_private
  eks_cluster_endpoint_public = var.eks_cluster_endpoint_public
  eks_cluster_endpoint_public_access_cidrs = var.eks_cluster_endpoint_public_access_cidrs
  eks_cluster_node_group_subnets = [module.vpc.public_subnet_id, module.vpc.private_subnet_id]
  eks_cluster_node_group_desired_size = var.eks_cluster_node_group_desired_size
  eks_cluster_node_group_max_size = var.eks_cluster_node_group_max_size
  eks_cluster_node_group_min_size = var.eks_cluster_node_group_min_size
  eks_cluster_node_group_instance_types = var.eks_cluster_node_group_instance_types
  eks_cluster_node_group_capacity_type = var.eks_cluster_node_group_capacity_type
  eks_cluster_node_group_labels = var.eks_cluster_node_group_labels
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_node_group_role_arn = module.iam.eks_node_group_role_arn
}