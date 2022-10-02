terraform {
  required_providers{
    aws = {
        source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = "ap-south-1"  
}
resource "aws_instance" "sailorec2instance" {
  instance_type = "t2.micro"
  ami = "ami-068257025f72f470d"
  key_name = aws_key_pair.sailorkeypair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sailorsg.id]
}
resource "aws_key_pair" "sailorkeypair" {
  key_name = "sailorkey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdndkQHnwjpix3M0H/j6K8GXXFVvKyQU8mI47bALm08vC+g5thV6NgqezBoWTTLtRZePrYlS1aQYRNBxj57SKXLtFrxlLGIBL9es9xf/hYGC4Gy/cWlfstK/RFarKvs4iM6SKTqdnqHSL8geBz8Z2ByReFwKl+Auc64a9IgRHfnJUv5KaF1sOwtJ9x135mCo9I8uyG+Opv37OP6vjEuGt6jTYTPxmHsDsX+sC4mINQJtbajifwQkb9zojO7mRYO1trddm/D71MdGMHaGuZtjlaABQvGBBmF3Z13pojLlIjS6ewS2Cj3ri6FNbOsTW6k0mTr2ngwv0q6j0K0463Ti8sv5S36SqFN9fAT31hZZYpHH6lR0DOGNAcdN5Jwrk7sKxpfM1teknCe4kXr1+GfHhBwgAHAjP38TjpvSikFoSUD6lzC61wHgzsDU2En3tVCx1pdjOwB6NJ4yPcNoIPa1YtjijsHsqn7bp3a2UxhL1lOxsppKppBsp8n3MQlCRHtfM= Sriman@DESKTOP-1QI4S5N"
}
resource "aws_security_group" "sailorsg" {
    ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress  {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 0
      protocol = -1
      self = false
      to_port = 0
    } 
  
}