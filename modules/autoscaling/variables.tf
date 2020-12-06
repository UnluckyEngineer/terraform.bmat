variable "ami" {}
variable "app_name" {}
variable "env" {}
variable "aws_keypair" {}
variable "sg_app" {}
variable "vpc_id" {}
variable "subnet_ids" {}
variable "instance_app_iam" { default = null }
variable "instance_type" {}
variable "as_min_size" { default = 0 }
variable "as_max_size" { default = 0 }
variable "as_desired_capacity" { default = 0 }
variable "health_check_grace_period" { default = 300 }
variable "health_check_type" { default = "ELB" }
variable "ebs_optimized" { default = "false" }
variable "root_volume_size" { default = "20" }
variable "enable_monitoring" { default = "false" }
variable "associate_public_ip_address" { default = "false" }
variable "as_metrics" { default = "GroupMinSize,GroupMaxSize,GroupDesiredCapacity,GroupInServiceInstances,GroupPendingInstances,GroupStandbyInstances,GroupTerminatingInstances,GroupTotalInstances" }

variable "create_as_policies" { default = "1" }
variable "adjustment_type" { default = "ChangeInCapacity" }
variable "scaling_adjustment_scaleup" { default = "1" }
variable "scaling_adjustment_scaledown" { default = "-1" }
variable "cooldown" { default = "60" }
variable "comparison_operator_scaleup" { default = "GreaterThanOrEqualToThreshold" }
variable "comparison_operator_scaledown" { default = "LessThanOrEqualToThreshold" }
variable "evaluation_periods_scaleup" { default = "1" }
variable "evaluation_periods_scaledown" { default = "2" }
variable "scaling_dimension_name" { default = "QueueName" }
variable "scaling_dimension_value" { default = "prod-bmat" }
variable "metric_name" { default = "CPUUtilization" }
variable "name_space" { default = "AWS/EC2" }
variable "period" { default = "60" }
variable "threshold_scaleup" { default = "60" }
variable "threshold_scaledown" { default = "30" }
variable "statistic" { default = "Average" }
variable "valid_statistics" {
  type = map(string)

  default = {
    Average     = "Average"
    Maximum     = "Maximum"
    Minimum     = "Minimum"
    SampleCount = "SampleCount"
    Sum         = "Sum"
  }
}
variable "target_group_port" { default = "443" }
variable "target_group_protocol" { default = "HTTPS" }
variable "target_group_path" { default = "/" }
variable "tags" {
  type = map

  default = {}
}
