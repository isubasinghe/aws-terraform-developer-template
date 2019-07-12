data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type   =   var.ec2_instance_type
    tags = {
        Name    =   var.ec2_instance_name
    }
    key_name    =   var.ec2_key_name

    vpc_security_group_ids = ["${aws_security_group.sydney_dev.id}"]

    root_block_device {
        delete_on_termination   =   true
        iops    =   100
        volume_size =   var.ec2_storage_size
    }

    provisioner "file" {
        source  =   "./.keys/key.key"
        destination =   "~/key.key"
    }

    provisioner "file" {
        source  =   "./.keys/cert.cert"
        destination =   "~/cert.cert"
    }
    
    provisioner "remote-exec" {
        scripts =   [
            "${path.module}/scripts/update.sh",
            "${path.module}/scripts/upgrade.sh",
            "${path.module}/scripts/install.sh",
            "${path.module}/scripts/coder.sh"
            ]
    }
    
    connection {
        host    =   self.public_ip
        type    =   "ssh"
        user    =   "ubuntu"
        password    =   ""
        private_key = "${file("")}"
    }
}