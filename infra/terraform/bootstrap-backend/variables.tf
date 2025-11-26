variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "todo"
}
