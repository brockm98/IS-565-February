# Create a subnet in which we can connect the EC2 instance to
resource "aws_subnet" "subnet-one" {
  cidr_block = "${cidrsubnet(aws_vpc.IS565-February-VPC.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.IS565-February-VPC.id}"
  availability_zone = "us-west-2a"
}

# Create a route table where we can route traffic to the EC2 instance
resource "aws_route_table" "route-table-ec2-february" {
  vpc_id = "${aws_vpc.IS565-February-VPC.id}"
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test-env-gw.id}"
  }
tags = {
    Name = "EC2 Route Table"
  }
}

# Associates a route table with a subnet
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.subnet-one.id}"
  route_table_id = "${aws_route_table.route-table-ec2-february.id}"
}