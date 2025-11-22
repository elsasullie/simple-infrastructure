resource "aws_instance" "web_1" {
  ami               = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type     = "t3.micro"
  subnet_id         = aws_subnet.public_1.id
  security_groups   = [aws_security_group.ec2_sg.id]

  user_data         = file("${path.module}/startup.sh")

  tags = {
    Name = "web-1"
  }
}

resource "aws_instance" "web_2" {
  ami               = "ami-0c02fb55956c7d316"
  instance_type     = "t3.micro"
  subnet_id         = aws_subnet.public_2.id
  security_groups   = [aws_security_group.ec2_sg.id]

  user_data         = file("${path.module}/startup.sh")

  tags = {
    Name = "web-2"
  }
}