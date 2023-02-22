# Enables internet access to and from your VPC
resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = "${aws_vpc.IS565-February-VPC.id}" # Connect the internet gateway to the VPC
  tags = {
    Name = "Kali EC2 Gateway"
  }
}