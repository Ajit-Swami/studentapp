vpc_name = "my-vpc"
vpc_cidr = "10.0.0.0/16"
project_name = "eks-cluster"
public_subnets = ["10.0.10.0/24"]
private_subnets = ["10.0.20.0/24"]
availability_zones = ["us-west-2a"]
security_group_description = "Security group for EKS"
private_subnet_az = "us-west-2b"
nat_gateway = true
public_route_table = true
tags = {
  Environment = "dev"
}

eks_cluster_role_name = "eks-cluster-role"
eks_node_group_role_name = "eks-node-group-role"
instance_profile_name = "my-instance-profile"

cluster_name = "my-eks-cluster"
eks_cluster_endpoint_private = true
eks_cluster_endpoint_public = true
eks_cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
eks_cluster_node_group_desired_size = 2
eks_cluster_node_group_max_size = 3
eks_cluster_node_group_min_size = 1
eks_cluster_node_group_instance_types = ["t3.micro"]
eks_cluster_node_group_capacity_type = "ON_DEMAND"
eks_cluster_node_group_labels = {
  "node-group" = "eks-node-group"
}