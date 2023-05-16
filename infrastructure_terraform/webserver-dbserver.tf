

#Create EC2 instances in public subnets
resource "aws_instance" "Pub2a_ec2" {
  ami             = var.ami-id
  instance_type   = var.instance-type
  key_name        = var.keypair-name
  subnet_id       = aws_subnet.public_sub2a.id
  security_groups = [aws_security_group.my_vpc_sg.id]

  user_data = <<-EOF
   #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    EOF

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-webserver1"
    },
  )
  provisioner "local-exec" {
    command = "echo [webserver1] >> /Users/santoshji/terraform/web-db-loadbalancer/ansible_vm_aws/inventory/vm_aws_playbook/hosts"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.Pub2a_ec2.public_ip} ansible_ssh_private_key_file=/Users/santoshji/terraform/web-db-loadbalancer/infrastructure_terraform/project-keypair.pem >> /Users/santoshji/terraform/web-db-loadbalancer/ansible_vm_aws/inventory/vm_aws_playbook/hosts"
  }

}

resource "aws_instance" "Pub2b_ec2" {
  ami             = var.ami-id
  instance_type   = var.instance-type
  key_name        = var.keypair-name
  subnet_id       = aws_subnet.public_sub2b.id
  security_groups = [aws_security_group.my_vpc_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    EOF

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-webserver2"
    },
  )

  provisioner "local-exec" {
    command = "echo [webserver2] >> /Users/santoshji/terraform/web-db-loadbalancer/ansible_vm_aws/inventory/vm_aws_playbook/hosts"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.Pub2b_ec2.public_ip} ansible_ssh_private_key_file=/Users/santoshji/terraform/web-db-loadbalancer/infrastructure_terraform/project-keypair.pem >> /Users/santoshji/terraform/web-db-loadbalancer/ansible_vm_aws/inventory/vm_aws_playbook/hosts"
    #command = "echo ${aws_instance.Pub2b_ec2.public_ip} ansible_ssh_private_key_file=/Users/santoshji/terraform/web-db-loadbalancer/infrastructure_terraform/project-keypair.pem >> /Users/santoshji/terraform/web-db-loadbalancer/ansible_vm_aws/inventory/vm_aws_playbook/hosts"
  }
}
/*
  provisioner "remote-exec" {
    inline=["Echo 'wait until ssh is ready'"]

    connection{
      type = "ssh"
      user = "ec2-user"
      private_key = "${var.keypair-name}.pem"
      host = aws_instance.Pub2b_ec2.public_ip
    } 
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.Pub2b_ec2.public_ip}, --private-key project-keypair.pem ansible-config-main.yaml"  
  }
}
*/

# Create a Database instance
resource "aws_db_instance" "db_instance" {
  allocated_storage      = 10
  db_name                = "my_private_db"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = "projectTerraform"
  password               = "Terraform1234"
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = "db_sub_grp"
  vpc_security_group_ids = [aws_security_group.my_vpc_sg.id]
  skip_final_snapshot    = true
}

resource "time_sleep" "wait_50_seconds" {
  depends_on       = [aws_db_instance.db_instance]
  destroy_duration = "50s"
}

#Create RDS instance subnet group
resource "aws_db_subnet_group" "db_sub_grp" {
  name       = "db_sub_grp"
  subnet_ids = [aws_subnet.db_private_sub2a.id, aws_subnet.db_private_sub2b.id]
}

/*
resource "local_file" "ansible_inventory" {
  content = aws_instance.Pub2a_ec2.public_ip
  filename="${path.module}/inventory" 
}
*/

