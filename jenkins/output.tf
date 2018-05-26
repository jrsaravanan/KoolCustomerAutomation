output "address" {
  value = "${aws_instance.web.public_ip}"
}

output "ssh" {
  value = "ssh ec2-user@${aws_instance.web.public_ip}"
}
