#create default security groups
# HTTP, SSH , TCP (8080) opened 

module "http_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name                = "${var.http-sg}"
  description         = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id              = "${module.vpc.vpc_id}"
  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "ssh_server_sg" {
  source              = "terraform-aws-modules/security-group/aws//modules/ssh"
  name                = "${var.ssh-wide-open-sg}"
  description         = "Security groups with SSH ports open "
  vpc_id              = "${module.vpc.vpc_id}"
  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "tcp_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "${var.tcp-sg-8080}"
  description = "Security group with TCP/8080 ports"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Port 8080"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
