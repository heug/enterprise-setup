# Ops key for CircleCI-managed solutions
# resource "aws_key_pair" "ops" {
#   key_name   = "${var.prefix}-ops"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCr9PNOZJz/d8hliq+CwxXYbgvz/ayx3sa2WiMogZPjhFv7JBHlp6Jh+NsjV/VakLCtOLPJ6cDtGWW9chTVVs5eaF2UTg9QIQU4N1PYE2LSi3qTfml/MQTMnCNQDYy2n1myb9p5YppjLRtvjovWhcRXIFW9TasxKqhBAFO0ZcWwQqyePtYMg8gDH5TV8Wxokq4jYcBvuq33EwBTJkjAJR6mmpnmGQERcPebv+6jTCbo36YEM8FGhzddWwHgQr7lc0d7hGQpuUSzoUmYJV/ohB0kQYtKheqILE2JJZ95LCrS7eVtZ9AzwEEilObGKni9q+Y9Z+SLIa5VNsZwzvrnI6v/"
# }

# It would seem as though we are using the 'services' box as a sort of bastion;
# however, there exists no concise security group for this purpose.
resource "aws_security_group" "ssh_from_services" {
  name   = "${var.prefix}-ssh-from-services"
  vpc_id = "${var.aws_vpc_id}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.vpc.circleci_services_sg_id}"]
  }
}

resource "aws_security_group" "circleci_mongo_client_sg" {
    name = "${var.prefix}_mongo_client_sg"
    description = "Mongo Clients"

    vpc_id = "${var.aws_vpc_id}"
    egress {
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        cidr_blocks = ["${var.cidr}"]
    }
}

resource "aws_security_group" "circleci_mongo_server_sg" {
    name = "${var.prefix}_mongo_server_sg"
    description = "Mongo Servers"

    vpc_id = "${var.aws_vpc_id}"
    ingress {
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        cidr_blocks = ["${var.cidr}"]
    }
    egress {
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        cidr_blocks = ["${var.cidr}"]
    }
    ingress {
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        security_groups = ["sg-3f1a5045"]
    }
}
