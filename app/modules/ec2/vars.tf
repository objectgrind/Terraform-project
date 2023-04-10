#   count         = "${var.ec2_count}"
#   ami           = "${var.ami_id}"
#   instance_type = "${var.instance_type}"
#   subnet_id     = "${var.subnet_id}"

variable "ec2_count" { 
    default = "1"
}

variable "ami_id"{

}

variable "instance_type" { 
    default = "t2.micro"
}

# variable "instance_profile" { 
    
    
# }

variable "subnet_id"{

}