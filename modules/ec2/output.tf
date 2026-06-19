output "instance1" {
  value = aws_instance.web1.id
}

output "instance2" {
  value = aws_instance.web2.id
}

output "web_sg" {
  value = aws_security_group.web_sg.id
}