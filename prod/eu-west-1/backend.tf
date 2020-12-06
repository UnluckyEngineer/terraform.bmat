terraform {
  #Required version of Terraform
  required_version = ">= 0.13"

  #In a real-world scenario, I would use backend 's3' or 'remote' which provide a remote state, but to keep things simple in this test I have used 'local'
  backend "local" {
      path = "../terraform.tfstate"
  }

  #Required providers and their versions
  required_providers {
    aws = {
      version = "~> 3.12.0"
      source  = "hashicorp/aws"
    }
  }
}
