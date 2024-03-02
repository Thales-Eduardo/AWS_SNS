terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.38.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "thales eduardo"
      managed-by = "terraform"
    }
  }
}

resource "aws_sns_topic" "sns" {
  name       = "terraform-test"
  fifo_topic = false
}

resource "aws_sns_topic_subscription" "http_subscription_microservice1" {
  topic_arn = aws_sns_topic.sns.arn
  protocol  = "http"
  endpoint  = "http://184.72.150.128:80"
}

resource "aws_sns_topic_subscription" "http_subscription_microservice2" {
  topic_arn = aws_sns_topic.sns.arn
  protocol  = "http"
  endpoint  = "http://54.147.150.243:80"
}

output "sns_arn" {
  description = "arn do tópico"
  value       = aws_sns_topic.sns.arn
}
