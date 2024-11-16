provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "terradici_instance" {
  ami           = ami-0ebfd941bbafe70c6
  type = string

  key_name = var.key_name # Add key pair for SSH access

  vpc_security_group_ids = [aws_security_group.terradici_sg.id] # Associate with the security group
  subnet_id              = var.subnet_id # Use the provided subnet

  tags = {
    Name = "terradici"
  }
}

# Define the Security Group for the EC2 instance
resource "aws_security_group" "terradici_sg" {
  name        = "terradici-sg"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (adjust for production)
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
