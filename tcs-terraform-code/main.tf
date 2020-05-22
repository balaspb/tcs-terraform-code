provider "aws" {
  region = "ap-south-1"
}
resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrH5FPHWX94tez1nlXyTqChu0g0gqtBMQ2fr6jSULxwqumbe1uIWtTNUpbb/piV18jRv4fVNhcv+P/vCZapE2+xUEIomsGLGbt+3Ly5H3978K5dM7vnG3hLuaUuRkphOXqtonZG3E3b43x/A0UxiDAZBsnxdFFveeKTBYL6EIP8bEz+csWXs4nxF9uew4/8WBlzoY3lQNeeGhRNpDRsfvjZlAreXW8+nascTr+4juH6uvKxcLgIAuqWQQgfe7a9ns7qH7PHzgtWzeRiIE5san+PL3qf4SfBEGE4F5MKHF86vEfItv+3fL7p01VlwH8xS4ikhsRVrzy0RwnToooABUv vyshnavi@DESKTOP-52SOND5"
}

resource "aws_security_group" "examplesg" {
   
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "web" {

  ami                    = "ami-0470e33cd681b2476"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.examplesg.id}"]
  key_name               = "${aws_key_pair.example.id}"
  tags = {
    Name = "web-server"
  }
}