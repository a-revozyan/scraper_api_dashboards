resource "aws_security_group" "sg_api01_service" {
  name = "allow 5050 for api01 service"
  description = "allow 5050 for api01 service"
  vpc_id = var.vpc_id
    ingress {
    description      = "TLS from VPC"
    from_port        = 5050
    to_port          = 5050
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.env}-api01-sg"
  }
}

resource "aws_security_group" "sg_dash01_service" {
  name = "allow 5000 for dash01 service"
  description = "allow 5000 for dash01 service"
  vpc_id = var.vpc_id
    ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.env}-dash01-sg"
  }
}


