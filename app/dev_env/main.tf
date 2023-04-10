terraform{
    backend s3 {
      bucket ="terraform-test-100"
        key   ="Key/terraform.tfstate"
        region ="us-east-1"
    }
}
provider "aws" {
    region = "us-east-1"
    
}

module "dev_networking"{
    source = "../modules/vpc"
    vpc_cidr = "192.168.0.0/16"
    tennacy = "default"
    vpc_id = "${module.dev_networking.vpc_id}"
    subnet_cidr = "192.168.1.0/24"

}   

module "dev_ec2"{
    source = "../modules/ec2"  
    ec2_count = 10
    # instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"
    ami_id = "ami-02f3f602d23f1659d"
    instance_type = "t2.micro"
    subnet_id     = "${module.dev_networking.subnet_id}"
  
}
