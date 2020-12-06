output "public_ids" {
  value = join(",", aws_subnet.public.*.id)
}

output "private_ids" {
  value = join(",", aws_subnet.private.*.id)
}

output "rtpriv_ids" {
  value = join(",", aws_route_table.rtpriv.*.id)
}

output "rtpub_ids" {
  value = join(",", aws_route_table.rtpub.*.id)
}
