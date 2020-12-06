output "sg_redis" {
  value = aws_security_group.sg_redis.id
}

output "sg_worker" {
  value = aws_security_group.sg_worker.id
}
