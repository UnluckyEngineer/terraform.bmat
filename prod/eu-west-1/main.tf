######################################
# VPC
######################################

module "vpc" {
  source              = "../../modules/vpc"
  env                 = var.general.env
  project_name        = var.general.project_name
  domain_name_servers = var.general.domain_name_servers
  aws_region          = var.aws_provider.region
  cidr                = var.network.cidr_vpc
  tags                = var.shared_tags
}

######################################
# Subnets
######################################

module "subnets" {
  source               = "../../modules/subnets"
  env                  = var.general.env
  project_name         = var.general.project_name
  aws_region           = var.aws_provider.region
  vpc_id               = module.vpc.vpc_id
  gw_id                = module.vpc.gw_id
  availablity_zones    = var.network.availablity_zones
  public_subnets_cidr  = var.network.public_subnets_cidr
  private_subnets_cidr = var.network.private_subnets_cidr
  nat_gateway_enabled  = "1"

  tags = var.shared_tags
}

######################################
# Security Groups      
######################################

module "securitygroups" {
  source       = "./modules/securitygroups"
  vpc_id       = module.vpc.vpc_id
  env          = var.general.env
  project_name = var.general.project_name

  tags = var.shared_tags
}

######################################
# Broker - Redis
######################################

module "redis" {
  count                      = (var.broker == "Redis" ? 1 : 0)
  source                     = "../../modules/elasticache-redis"
  env                        = var.general.env
  vpc_id                     = module.vpc.vpc_id
  redis_name                 = var.redis.name
  sg_redis_ids               = [module.securitygroups.sg_redis]
  subnet_ids                 = split(",", module.subnets.private_ids)
  az                         = split(",", var.redis.az)
  desired_clusters           = var.redis.nb_nodes
  instance_type              = var.redis.instance_type
  engine_version             = var.redis.engine_version
  new_parameter_group_family = var.redis.parameter_group_family
  new_parameter_group_name   = var.redis.new_parameter_group_name
  encryption_enabled         = var.redis.encryption_enabled

  tags = var.shared_tags
}

######################################
# Broker - SQS
######################################

module "sqs" {
  count  = (var.broker == "SQS" ? 1 : 0)
  source = "../../modules/sqs"
  env    = var.general.env
  name   = var.sqs.name

  tags = var.shared_tags
}

######################################
# Autoscaling Workers
######################################

module "autoscaling_workers" {
  source              = "../../modules/autoscaling"
  vpc_id              = module.vpc.vpc_id
  env                 = var.general.env
  aws_keypair         = var.general.key_pair
  ami                 = var.asg_workers.ami
  root_volume_size    = var.asg_workers.root_volume_size
  app_name            = var.asg_workers.app_name
  instance_type       = var.asg_workers.instance_type
  as_min_size         = var.asg_workers.min_size
  as_desired_capacity = var.asg_workers.desired_size
  as_max_size         = var.asg_workers.max_size
  sg_app              = module.securitygroups.sg_worker
  subnet_ids          = module.subnets.private_ids
  #Scaling configuration
  name_space                    = (var.broker == "SQS" ? "AWS/SQS" : var.asg_workers.custom_metric_namespace)
  metric_name                   = (var.broker == "SQS" ? "ApproximateNumberOfMessagesVisible" : var.asg_workers.custom_metric_name)
  scaling_dimension_name        = "QueueName"
  scaling_dimension_value       = (var.broker == "SQS" ? module.sqs[0].name : "prod-bmat")
  comparison_operator_scaleup   = "GreaterThanThreshold"
  threshold_scaleup             = 4
  comparison_operator_scaledown = "LessThanOrEqualToThreshold"
  threshold_scaledown           = 0

  tags = var.shared_tags
}
