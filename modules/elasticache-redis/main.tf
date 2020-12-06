resource "aws_elasticache_parameter_group" "new_pg" {
  name   = var.new_parameter_group_name
  family = var.new_parameter_group_family

  dynamic "parameter" {
    for_each = var.new_parameter_group_params
    content {
      name  = parameter.key
      value = parameter.value
    }
  }
}

resource "aws_elasticache_subnet_group" "new_subnet_group" {
  name       = "subnet-redis-${var.env}-${lower(var.redis_name)}"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_replication_group" "new_redis_pg" {
  replication_group_id          = "redis-${var.env}-${lower(var.redis_name)}"
  replication_group_description = "Replication group for Redis ${lower(var.redis_name)} in ${var.env}"
  automatic_failover_enabled    = var.automatic_failover_enabled
  number_cache_clusters         = var.desired_clusters
  node_type                     = var.instance_type
  engine_version                = var.engine_version
  parameter_group_name          = var.new_parameter_group_name
  subnet_group_name             = aws_elasticache_subnet_group.new_subnet_group.name
  availability_zones            = var.az
  security_group_ids            = var.sg_redis_ids
  port                          = "6379"
  snapshot_retention_limit      = var.snapshot_retention_days
  snapshot_window               = var.snapshot_retention_days == "0" ? "" : var.snapshot_window
  at_rest_encryption_enabled    = var.encryption_enabled
  apply_immediately             = true

  tags = var.tags

  lifecycle {
    ignore_changes = [engine_version]
  }
}
