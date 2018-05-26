variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "ap-south-1"
}

variable "http-sg" {
  description = "AWS HTTP default security groups"
  default     = "sg_common_http"
}

variable "ssh-wide-open-sg" {
  description = "Security groups with SSH ports open"
  default     = "sg_common_ssh"
}

variable "tcp-sg-8080" {
  description = "Security groups with TCP(8080) ports open"
  default     = "sg_common_tcp_8080"
}
