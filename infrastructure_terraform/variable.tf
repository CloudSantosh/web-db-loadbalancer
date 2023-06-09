variable "region" {
  type        = string
  default     = "us-west-2"
  description = "It defines region of aws"
}

variable "name_prefix" {
  default     = "AWS-ReStart"
  description = "Name prefix for resources on AWS"
}


variable "additional_tags" {
  default     = {}
  type        = map(string)
  description = "Additional resource tags"
}

variable "availability_zone" {
  type        = list(any)
  default     = ["us-west-2a", "us-west-2b"]
  description = "defining availibility zone"

}

variable "cidr_vpc" {
  type        = string
  default     = "192.168.0.0/16"
  description = "CIDR Block for VPC"
}
/*
variable "tag_name" {
  type        = string
  default     = "theshortcut_project"
  description = "name for the tag"

}

variable "subnet-public" {
  type        = string
  default     = "192.168.0.0/24"
  description = "public subnet"

}

variable "webserver" {
  type        = string
  default     = "WebServer"
  description = "Name for webserver instances"
}

variable "sg" {
  type        = string
  default     = "project-sg"
  description = "Security Group rules"
}

data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  my_ip = jsondecode(data.http.my_public_ip.body)
}
*/
variable "keypair-algorithm" {
  type        = string
  default     = "RSA"
  description = "Algorithm used for generation of keypair"
}

variable "keypair-name" {
  type        = string
  default     = "project-keypair"
  description = "Name of keypair"
}
variable "rsa-bit" {
  type        = number
  default     = 4096
  description = "RSA bit used"
}

/*
variable "base_path" {
  type        = string
  default     = path.module
  description = "path to download pem file"
}
*/


variable "ami-id" {
  type        = string
  default     = "ami-04e914639d0cca79a"
  description = "AMI id"

}
variable "instance-type" {
  type        = string
  default     = "t2.micro"
  description = "this is instance type"

}

variable "boolean" {
  type        = bool
  default     = true
  description = "boolean value for yes or no"
}

variable "bucket_name_1" {
  type = string
  //type = list(string)
  //default = [ "patients-dataset1111111","amplify-doctorspatientsapp-staging-73102-deployment1111","amplify-amplifydemo-staging-71413-deployment1111" ]
  default = "patients-dataset1111111"
}

variable "bucket_name_2" {
  type = string
  //default = [ "patients-dataset1111111","amplify-doctorspatientsapp-staging-73102-deployment1111","amplify-amplifydemo-staging-71413-deployment1111" ]
  default = "amplify-doctorspatientsapp-staging-73102-deployment1111"
}

variable "bucket_name_3" {
  type    = string
  default = "amplify-amplifydemo-staging-71413-deployment1111"

}