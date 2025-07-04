
resource "aws_instance" "roboshop" {
  count = 4    # create four similar EC2 instances
  ami           = var.ami_id    # left and right side names no need to be same
  instance_type = var.environment == "dev" ? "t3.micro" : "t3.small"
  vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  #vpc_security_group_ids = local.sg_id

   tags = {
    Name = var.instances[count.index]
   }
}

resource "aws_security_group" "allow_all" {
    name        = var.sg_name
    description = var.sg_description

    ingress {
        from_port        = var.from_port
        to_port          = var.to_port
        protocol         = "-1"      #Allowing all ports
        cidr_blocks      = var.cidr_blocks
        ipv6_cidr_blocks = ["::/0"]
  }

    egress {
        from_port        = var.from_port
        to_port          = var.to_port
        protocol         = "-1"      #Allowing all ports
        cidr_blocks      = var.cidr_blocks
        ipv6_cidr_blocks = ["::/0"]
  }
    
    tags = var.sg_tags

}