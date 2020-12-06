output "app_as_standalone_name" {
  value = element(concat(aws_autoscaling_group.as-app-standalone.*.name, list("")), 0)
}

output "app_as_standalone_id" {
  value = element(concat(aws_autoscaling_group.as-app-standalone.*.id, list("")), 0)
}

output "app_as_standalone_arn" {
  value = element(concat(aws_autoscaling_group.as-app-standalone.*.arn, list("")), 0)
}
