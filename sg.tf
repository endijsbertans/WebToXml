# Creates SG for ALB Allows all ports
resource "aws_security_group" "lb_sg" {
  name        = "lb2_sg"
  description = "Application Load Balancer for lambda invocation"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "All ports open!"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "lb_sg"
  }
}