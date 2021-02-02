provider "aws" {
	access_key = ""
	secret_key = ""
	region     = "us-east-2"
}

variable "instance_type" {
	default = "t2.micro"
}

resource "aws_instance" "ec2_instance_course" {
	ami = "ami-0a91cd140a1fc148a"
	instance_type = var.instance_type
	key_name = "course_ISD"
	security_groups = [aws_security_group.ec2_security_group_course.name]
}

resource "aws_security_group" "ec2_security_group_course" {
    name = "ec2_ubuntu20_lemp_security_course"

    ingress {
        cidr_blocks = [
        "0.0.0.0/0"
        ]

        from_port = 22
        to_port = 22
        protocol = "tcp"
    }
    ingress {
        cidr_blocks = [
        "0.0.0.0/0"
        ]
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
    }

    ingress {
        cidr_blocks = [
        "0.0.0.0/0"
        ]
        from_port = 8183
        to_port = 8183
        protocol = "tcp"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "ip" {
	value = aws_instance.ec2_instance_course.public_ip
}

resource "local_file" "ansibleHost" {
    content = templatefile("inventory",
        {
            public_ip = aws_instance.ec2_instance_course.public_ip,
        }
    )
    filename = "inventory"
}