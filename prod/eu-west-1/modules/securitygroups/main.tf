# Redis
resource "aws_security_group" "sg_redis" {
  name        = "sg.${var.env}.${var.project_name}.redis"
  description = "Security group for Elasticache Redis"
  vpc_id      = var.vpc_id

  tags = merge(var.tags,
    map(
      "Name", "sg.${var.env}.${var.project_name}.redis",
    )
  )

  # Access rule for outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Redis
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    description     = "Redis"
    security_groups = [aws_security_group.sg_worker.id]
  }
}

# Redis
resource "aws_security_group" "sg_worker" {
  name        = "sg.${var.env}.${var.project_name}.worker"
  description = "Security group for EC2 workers"
  vpc_id      = var.vpc_id

  tags = merge(var.tags,
    map(
      "Name", "sg.${var.env}.${var.project_name}.worker",
    )
  )

  # Access rule for outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
