variable "aws_provider" {
  default = {
    region      = "eu-west-1"
    credentials = "~/.aws/credentials"
  }
}

variable "aws_profile" {
  description = "AWS profile name (in your credentials file) that you want to use to deploy the solution"
}

variable "general" {
  default = {
    env                 = "prod"
    project_name        = "bmat"
    domain_name_servers = "127.0.0.1,AmazonProvidedDNS"
    key_pair            = "aws_bmat_prod"
  }
}

variable "network" {
  description = "Network variables"
  default = {
    cidr_vpc             = "10.111.0.0/16"
    availablity_zones    = "a,b,c"
    public_subnets_cidr  = "10.111.0.0/24,10.111.1.0/24,10.111.2.0/24"
    private_subnets_cidr = "10.111.3.0/24,10.111.4.0/24,10.111.5.0/24"
  }
}

variable "shared_tags" {
  description = "Shared Tags"

  default = {
    Environment = "PROD"
    Platform    = "BMAT"
  }
}

variable "redis" {
  description = "Variables for the Elasticache Redis"

  default = {
    name                     = "bmat"
    az                       = "eu-west-1a,eu-west-1b"
    nb_nodes                 = "2" #It's mandatory to define this variable to the number of AZ listed in the az variable
    instance_type            = "cache.t3.micro"
    engine_version           = "6.x"
    parameter_group_family   = "redis6.x"
    new_parameter_group_name = "bmat"
    encryption_enabled       = true
  }
}

variable "sqs" {
  description = "Variables for SQS"

  default = {
    name = "bmat"
  }
}

variable "asg_workers" {
  description = "Autoscaling Information for the Workers"

  default = {
    ami                     = "ami-0aef57767f5404a3c"
    app_name                = "bmat.worker"
    instance_type           = "t2.micro"
    root_volume_size        = 8
    min_size                = 0
    desired_size            = 0
    max_size                = 4
    custom_metric_namespace = "BMAT"
    custom_metric_name      = "PendingJobs"
  }
}

variable "broker" {
  description = "Defines the broker to use between Redis and SQS"
  default     = "Redis"
}
