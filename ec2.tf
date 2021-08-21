resource "aws_instance" "bastion" {
    count  = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets   
    key_name      = aws_key_pair.praise.key_name
    ami           = var.bastion_ami
    instance_type = "t2.micro"
    vpc_security_group_ids = [
        aws_security_group.bastion_sg.id
    ]
    iam_instance_profile = aws_iam_instance_profile.ip.name
    subnet_id = element(aws_subnet.public.*.id,count.index)
    associate_public_ip_address = true
    source_dest_check = false
    tags = {
        Name = "Bastion-Test${count.index}"
    }
}

resource "aws_instance" "webserver" {
    count  = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets  
    key_name      = aws_key_pair.praise.key_name
    ami           = var.webserver_ami
    instance_type = "t2.micro"
    vpc_security_group_ids = [
        aws_security_group.web_sg.id
    ]
    subnet_id = element(aws_subnet.private.*.id,count.index)
    associate_public_ip_address = false
    source_dest_check = false
    tags = {
        Name = "private-Test${count.index}"
    }
}