provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0a716d3f3b16d290c" 
  instance_type = "t3.micro"
  availability_zone = "eu-north-1a"
  key_name      = "ipat-eunorth1"

  tags = {
    Name = "firststsproject"
  }
}
