

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
    echo "<h1>Code finally Worked.EC2 instance launched in us-west-2a!!!</h1>" > var/www/html/index.html
    EOF

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-webserver1"
    },
  )
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
    echo "<h1>Code finally Worked.EC2 instance launched in us-west-2b!!!</h1>" > var/www/html/index.html
    EOF

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-webserver2"
    },
  )
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
/*
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

#Create RDS instance subnet group
resource "aws_db_subnet_group" "db_sub_grp" {
  name       = "db_sub_grp"
  subnet_ids = [aws_subnet.db_private_sub2a.id, aws_subnet.db_private_sub2b.id]
}
*/

/*
resource "local_file" "ansible_inventory" {
  content = aws_instance.Pub2a_ec2.public_ip
  filename="${path.module}/inventory" 
}
*/

