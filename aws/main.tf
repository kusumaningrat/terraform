resource "aws_instance" "example" {
  count = 2
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  tags = {
   Name = "Node${count.index + 1}"
  }
  
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = "${var.security_group_id["mysec-group"]}"
  associate_public_ip_address = true
  key_name = "${var.key_pairs}"
}
