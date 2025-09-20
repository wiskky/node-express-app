variable "dockerhub_username" {
  type = string
}

variable "docker_image_name" {
  type = string
}

variable "docker_image_tag" {
  type = string
}
# AWS settings
variable "region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "eu-north-1"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
  default     = "ami-0a716d3f3b16d290c"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_pair_name" {
  type        = string
  description = "Name of the existing AWS EC2 key pair"
  default     = "dream-key"
}





