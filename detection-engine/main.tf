# Create EC2 instance with the sysdig installed
resource "aws_instance" "rules-engine" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.allow_ssh.name]

  # User data script to install Sysdig
  user_data = <<-EOF
              #!/bin/bash
              curl -s https://s3.amazonaws.com/download.draios.com/stable/install-sysdig | sudo bash
            EOF
  tags = {
    Name = "rules-engine"
  }
}

# Upload my public key to AWS
resource "aws_key_pair" "my_key_pair" {
  key_name   = "wsl-ubuntu-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

# Create a Security Group to allow SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Output the public IP of the instance
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.rules-engine.public_ip
}
