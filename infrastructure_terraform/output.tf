output "aws_instance_pub2a_ec2" {
  value       = aws_instance.Pub2a_ec2.public_ip
  description = "display ip address of websever1"
}

output "aws_instance_pub2b_ec2" {
  value       = aws_instance.Pub2b_ec2.public_ip
  description = "display public ip address of websever2"
}


output "aws_lb_my-aws-alb" {
  value       = aws_lb.my-aws-alb.dns_name
  description = "displays dns name to log in "

}

