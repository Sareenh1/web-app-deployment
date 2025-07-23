provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "web_server" {
  count         = 10
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t2.medium"
  
  tags = {
    Name = "web-server-${count.index + 1}"
  }
  
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y docker.io
              sudo systemctl enable --now docker
              EOF
}

output "instance_ips" {
  value = aws_instance.web_server[*].public_ip
}
