resource "aws_security_group" "sg_api01_service" {
  name = "allow ${var.api_port_sec_group} for api01 service"
  description = "allow ${var.api_port_sec_group} for api01 service"
  vpc_id = var.vpc_id
    ingress {
    description      = "${var.api_port_sec_group} from VPC"
    from_port        = var.api_port_sec_group
    to_port          = var.api_port_sec_group
    protocol         = var.tcp
    cidr_blocks      = [var.cidr_block]
  }

  egress {
    from_port        = var.egress_port
    to_port          = var.egress_port
    protocol         = var.protocol_egress
    cidr_blocks      = [var.cidr_block]
  }

  tags = {
    Name = "${var.env}-api01-sg"
  }
}

resource "aws_security_group" "sg_dash01_service" {
  name = "allow ${var.dash_port_sec_group} for dash01 service"
  description = "allow ${var.dash_port_sec_group} for dash01 service"
  vpc_id = var.vpc_id
    ingress {
    description      = "${var.dash_port_sec_group} from VPC"
    from_port        = var.dash_port_sec_group
    to_port          = var.dash_port_sec_group
    protocol         = var.tcp
    cidr_blocks      = [var.cidr_block]
  }

  egress {
    from_port        = var.egress_port
    to_port          = var.egress_port
    protocol         = var.protocol_egress
    cidr_blocks      = [var.cidr_block]
  }

  tags = {
    Name = "${var.env}-dash01-sg"
  }
}


