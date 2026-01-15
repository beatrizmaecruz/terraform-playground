resource "aws_security_group" "sg" {
  name        = "Basic Security Group"
  description = "Allow port 80 for HTTP"

  tags = {
    Name = "Basic-security-group"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_instance" "web" {
  ami           = "ami-0b3c832b6b7289e44"  # Change the AMI accordingly
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]

  user_data     = file("userdata.sh")

  tags = {
    Name = "basic-terra"
  }
}

output "instance_public_ip" {
  value       = aws_instance.web.public_ip
  description = "Website is running on this address:"
}