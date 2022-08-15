variable "aws_access_key" {
    default = ""
}

variable "aws_secret_key" {
    default = ""
}

variable "region" {
  default = ""
}

variable "availability_zone" {
    default = ""
}

variable "jenkins" {
    default = "ami-02f3416038bdb17fb"
}

variable "instance_type" {
    default = "t2.medium"
}

variable "root_volume_size" {
    default = 16 
}

variable "instance_count" {
    default = 1
}

variable "delete_on_termination" {
    default = true
}

variable "volume_size" {
    default = 20
}

variable "volume_type" {
    default = "gp2"
}

#name keypar
variable "key_name" {
    default = ""
}

variable "vpc_security_group_ids" {
    default = ["sg-0aa51f18c9657d174"]
}

variable "associate_public_ip_address" {
    default = true
}

variable "tags" {
    type = map(string)
    default = {
        "name" = "jenkins-cilist"
        "purpose" = "launch-jenkins"
        "env" = "dev"
    }
}