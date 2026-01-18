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

resource "aws_vpc_security_group_ingress_rule" "ingress_http" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "ingress_https" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ssh" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}


resource "aws_key_pair" "key_pair" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/mykey.pub")
}

resource "aws_instance" "web" {
  ami           = "ami-0ef6d0055be7553ee"  # AMI for Debian (compatible with apt)
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name      = aws_key_pair.key_pair.key_name
  user_data     = file("userdata.sh")

  tags = {
    Name = "basic-terra"
  }
}

output "instance_public_ip" {
  value       = aws_instance.web.public_ip
  description = "Website is running on this address:"
}