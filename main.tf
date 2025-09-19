provider "aws" {
  region = var.region
}

resource "aws_security_group" "app_security_group" {
  name_prefix = "node-app-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_instance" "node_app_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.app_security_group.id]

  # Pass the Docker image tag variable to the user data script
  user_data = templatefile("user_data.sh", {
    docker_image = "${var.dockerhub_username}/${var.docker_image_name}:${var.docker_image_tag}"
    # HOST_APP_DIR = "/home/ubuntu/app"
  })

  tags = {
    Name        = "node-app-server"
  }
}

output "public_ip" {
  value = aws_instance.node_app_instance.public_ip
}