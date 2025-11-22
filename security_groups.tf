resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
  description = "Allow HTTP from internet"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "lb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb_http_in" {
  security_group_id = aws_security_group.lb_sg.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "lb_all_out" {
  security_group_id = aws_security_group.lb_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow HTTP from LB"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "ec2-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2_http_from_lb" {
  security_group_id              = aws_security_group.ec2_sg.id
  from_port                      = 80
  to_port                        = 80
  ip_protocol                    = "tcp"
  referenced_security_group_id  = aws_security_group.lb_sg.id
}

resource "aws_vpc_security_group_egress_rule" "ec2_all_out" {
  security_group_id = aws_security_group.ec2_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}