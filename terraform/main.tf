provider "aws" {
  region = "eu-north-1"
}

# -------------------------------
# Security Group (Allows SSH + Tomcat)
# -------------------------------
resource "aws_security_group" "ec2_sg" {
  name = "stsproject-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # For Jenkins SSH (change later if needed)
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # To access Tomcat
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -------------------------------
# EC2 Instance
# -------------------------------
resource "aws_instance" "capstone" {
  ami                    = "ami-0a716d3f3b16d290c"
  instance_type          = "t3.micro"
  availability_zone      = "eu-north-1a"
  key_name               = "ipat-eunorth1.2"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # Auto-install Tomcat
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install tomcat10 -y
              systemctl enable tomcat10
              systemctl start tomcat10
              EOF

  tags = {
    Name = "firststsproject"
  }
}
