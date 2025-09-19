variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "eu-north-1"
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance (Ubuntu)."
  type        = string
  default     = "ami-0a716d3f3b16d290c"
}

variable "key_pair_name" {
  description = "The name of your EC2 key pair."
  type        = string
  default     = "dream-key"
}

variable "dockerhub_username" {
  description = "Your Docker Hub username."
  type        = string
  default     = "wiskky"
}

variable "docker_image_name" {
  description = "The name of the Docker image."
  type        = string
  default     = "node-express-app"
}

variable "docker_image_tag" {
  description = "The tag for the Docker image."
  type        = string
  default     = "v1.1"
}