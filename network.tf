# Creates a Virtual Private Cloud instance where all resources live in
resource "aws_vpc" "IS565-February-VPC" {
  cidr_block = "10.0.0.0/16"  # Primary cidr block for a VPC
  enable_dns_hostnames = true # Allows for EC2 Instances to be called from a URL or a IP address
  enable_dns_support = true   # Allows for EC2 Instances to be called from a URL or a IP address
  tags = {
    Name = "IS565-February"
  }
}

# An Elastic IP that can be used to connect to the EC2 Instance
resource "aws_eip" "ip-address" {
  instance = "${aws_instance.kali-ec2.id}" # Tie the EC2 instance to the Elastic IP
  vpc      = true # This Elastic IP is used within a VPC
}