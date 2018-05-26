provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "auth" {
  key_name   = "aws_local_key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "web" {
  ami                  = "ami-7c87d913"
  instance_type        = "t2.micro"
  subnet_id            = "subnet-919d60dd"
  security_groups      = ["sg-0e25bc2897d7f6502"]
  key_name             = "${aws_key_pair.auth.key_name}"
  iam_instance_profile = "S3AdminRole"

  tags {
    Name = "dev-jenkins-server"
  }

  # force Terraform to wait until a connection can be made, so that Ansible doesn't fail when trying to provision
  provisioner "remote-exec" {
    # The connection will use the local SSH agent for authentication
    inline = ["echo Successfully connected"]

    # The connection block tells our provisioner how to communicate with the resource (instance)
    connection {
      user = "ec2-user"
    }
  }
}

resource "aws_instance" "admin" {
  ami                  = "ami-7c87d913"
  instance_type        = "t2.micro"
  subnet_id            = "subnet-919d60dd"
  security_groups      = ["sg-0e25bc2897d7f6502"]
  key_name             = "${aws_key_pair.auth.key_name}"
  iam_instance_profile = "S3AdminRole"

  tags {
    Name = "customer-dev-admin"
  }
}
