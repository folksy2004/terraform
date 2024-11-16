provider "aws" {
  region = "us-east-1"
}

# Security Group for the EC2 instance
resource "aws_security_group" "terradici_sg" {
  name        = "terradici-sg"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

# EC2 Instance
resource "aws_instance" "terradici_instance" {
  ami           = "ami-0ebfd941bbafe70c6" # Replace with your AMI ID
  instance_type = "t2.micro"              # Replace with your desired instance type

  tags = {
    Name = "terradici"
  }

  key_name = "Demokeys"              # Replace with your SSH key name

  vpc_security_group_ids = [aws_security_group.terradici_sg.id]
  subnet_id              = "subnet-0b058521c9f4f5d53" # Replace with your subnet ID
}

# Outputs
output "instance_id" {
  value = aws_instance.terradici_instance.id
}

output "instance_public_ip" {
  value = aws_instance.terradici_instance.public_ip
}

output "security_group_id" {
  value = aws_security_group.terradici_sg.id
}

