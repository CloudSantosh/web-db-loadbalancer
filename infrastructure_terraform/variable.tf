variable "region" {
  type        = string
  default     = "us-west-2"
  description = "It defines region of aws"
}

/*variable "az" {
  type        = string
  default     = "us-west-2a"
  description = "defining availibility zone"

}
*/
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
