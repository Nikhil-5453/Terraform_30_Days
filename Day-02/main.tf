
resource "aws_security_group" "new_sg" {
  name        = "new_sg"
  description = "Security group for new instance"
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
  ami           = "ami-0f559c3642608c138"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.new_sg.name]
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  
}

