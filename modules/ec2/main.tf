resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web1" {
  ami                    = "ami-0c1a7f89451184c8b"
  instance_type          = "t3.micro"
  subnet_id              = var.subnet1
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
               apt update -y
               apt install apache2 -y
               systemctl start apache2
               systemctl enable apache2
              echo "<h1>Hello from Web Server 1</h1>" > /var/www/html/index.html
            EOF
  tags = {
    Name = "WebServer"
  }
}

resource "aws_instance" "web2" {
  ami                    = "ami-0c1a7f89451184c8b"
  instance_type          = "t3.micro"
  subnet_id              = var.subnet2
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
               apt update -y
               apt install apache2 -y
               systemctl start apache2
               systemctl enable apache2
              echo "<h1>Hello from Web Server 2</h1>" > /var/www/html/index.html
            EOF
  tags = {
    Name = "WebServer2"
  }
}