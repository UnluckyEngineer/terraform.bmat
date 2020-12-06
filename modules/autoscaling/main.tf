#Create the Launch Configuration
resource "aws_launch_configuration" "lc-app" {
  name_prefix                 = "launchconfig.${var.env}.${var.app_name}"
  image_id                    = var.ami
  instance_type               = var.instance_type
  iam_instance_profile        = var.instance_app_iam
  key_name                    = var.aws_keypair
  security_groups             = split(",", var.sg_app)
  ebs_optimized               = var.ebs_optimized
  associate_public_ip_address = var.associate_public_ip_address
  enable_monitoring           = var.enable_monitoring

  root_block_device {
    volume_type = "gp2"
    volume_size = var.root_volume_size
    encrypted   = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

#Create a Standalone the Autoscaling Group
resource "aws_autoscaling_group" "as-app-standalone" {
  name                 = "as-${var.env}-${var.app_name}"
  launch_configuration = aws_launch_configuration.lc-app.name
  min_size             = var.as_min_size
  max_size             = var.as_max_size
  desired_capacity     = var.as_desired_capacity

  enabled_metrics           = split(",", var.as_metrics)
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type

  vpc_zone_identifier = split(",", var.subnet_ids)

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.env}.${var.app_name}"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
