terraform {
  backend "s3" {
    bucket         = "todo-tfstate-5a42f3"
    key            = "eks-cluster/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "todo-tf-lock"
    encrypt        = true
  }
}
