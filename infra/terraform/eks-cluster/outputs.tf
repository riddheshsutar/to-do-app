# EKS Cluster Info
output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "API endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

# Security Groups
output "node_security_group_id" {
  description = "Security group for the EKS worker nodes"
  value       = module.eks.node_security_group_id
}

output "cluster_security_group_id" {
  description = "Security group for the EKS control plane"
  value       = module.eks.cluster_security_group_id
}
