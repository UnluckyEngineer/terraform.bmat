## Creates simple scaling policy for scale UP
resource "aws_autoscaling_policy" "asg_policy_scaleup" {
  count                  = var.create_as_policies
  adjustment_type        = var.adjustment_type
  autoscaling_group_name = "as-${var.env}-${var.app_name}"
  cooldown               = var.cooldown
  name                   = "policy-scaleup-${var.app_name}"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = var.scaling_adjustment_scaleup

  depends_on = [aws_autoscaling_group.as-app-standalone]
}

## Creates CloudWatch ScaleUP Alarm
resource "aws_cloudwatch_metric_alarm" "metric_scaleup" {
  count               = var.create_as_policies
  actions_enabled     = true
  alarm_actions       = [aws_autoscaling_policy.asg_policy_scaleup[count.index].arn]
  alarm_description   = "ScaleUP Metric for the Autoscaling Group ${var.app_name} in ${var.env} env"
  alarm_name          = "scaleup-policy-${var.app_name}-${var.env}"
  comparison_operator = var.comparison_operator_scaleup

  dimensions = {
    (var.scaling_dimension_name) = (var.scaling_dimension_value)
  }

  evaluation_periods = var.evaluation_periods_scaleup
  metric_name        = var.metric_name
  namespace          = var.name_space
  period             = var.period
  statistic          = lookup(var.valid_statistics, var.statistic)
  threshold          = var.threshold_scaleup
}

## Creates simple scaling policy for scale DOWN
resource "aws_autoscaling_policy" "asg_policy_scaledown" {
  count                  = var.create_as_policies
  adjustment_type        = var.adjustment_type
  autoscaling_group_name = "as-${var.env}-${var.app_name}"
  cooldown               = var.cooldown
  name                   = "policy-scaledown-${var.app_name}"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = var.scaling_adjustment_scaledown

  depends_on = [aws_autoscaling_group.as-app-standalone]
}

## Creates CloudWatch ScaleDOWN Alarm
resource "aws_cloudwatch_metric_alarm" "metric_scaledown" {
  count               = var.create_as_policies
  actions_enabled     = true
  alarm_actions       = [aws_autoscaling_policy.asg_policy_scaledown[count.index].arn]
  alarm_description   = "ScaleDOWN Metric for the Autoscaling Group ${var.app_name} in ${var.env} env"
  alarm_name          = "scaledown-policy-${var.app_name}-${var.env}"
  comparison_operator = var.comparison_operator_scaledown

  dimensions = {
    (var.scaling_dimension_name) = (var.scaling_dimension_value)
  }

  evaluation_periods = var.evaluation_periods_scaledown
  metric_name        = var.metric_name
  namespace          = var.name_space
  period             = var.period
  statistic          = lookup(var.valid_statistics, var.statistic)
  threshold          = var.threshold_scaledown
}
