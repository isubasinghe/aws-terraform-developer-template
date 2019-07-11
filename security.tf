resource "aws_security_group" "sydney_dev" {
    name    =   "sydney_dev"

    ingress {
        protocol    =   "tcp"
        from_port   =   22
        to_port =   22
        cidr_blocks =   ["0.0.0.0/0"]
    }

    ingress {
        protocol    =   "tcp"
        from_port   =   80
        to_port =   80
        cidr_blocks =   ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }
}