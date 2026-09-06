resource "aws_security_group" "new_sg" {
  name        = "new1_sg"
  description = "Security group for new instance"
  tags = {
    Name = "new1_sg"
  }
}

resource "aws_security_group_rule" "inbound_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new_sg.id
}

resource "aws_security_group_rule" "inbound_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new_sg.id
}
resource "aws_security_group_rule" "inbound_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new_sg.id
}


resource "aws_instance" "new_instance" {
  count = 1
  ami           = "ami-090d68841c2a28756"
  instance_type = "t3.micro"
  key_name      = "new"
  security_groups = [aws_security_group.new_sg.name]
  iam_instance_profile = "ADMIN_ROLE"
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  tags = {
    Name = "new_Test_instance"
  }
  
}

