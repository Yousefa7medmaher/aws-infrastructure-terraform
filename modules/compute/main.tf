data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}



resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.this.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  associate_public_ip_address = true 
  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl enable nginx
              systemctl start nginx

              echo "Hello from Terraform EC2 " > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = var.name
  }
}

