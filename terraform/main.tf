provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "terradici_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "terradici"
  }

  # Example for adding a key pair
  key_name = var.key_name

  # Optional security group
  vpc_security_group_ids = [aws_security_group.terradici_sg.id]

  # Optional subnet
  subnet_id = var.subnet_id
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
