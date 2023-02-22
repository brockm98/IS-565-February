# Create the Virtual Machine in EC2
resource "aws_instance" "kali-ec2" {
  ami = "${data.aws_ami.kali-ec2-ami.id}"                   # The image identifier
  instance_type = "t2.micro"                                # t2.micro is typically the smallest and cheapest EC2 instance
  key_name = "${aws_key_pair.generated_key.key_name}"       # Allow ssh connections only from the key pair generated
  security_groups = ["${aws_security_group.kali-sg.id}"]    # Only allow connections from the security group
  tags = {
    Name = "Kali Linux"
  }
  subnet_id = "${aws_subnet.subnet-one.id}"                 # Notes which subnet we connected the EC2 instance to
}

# Grab the latest Amazon Image for Kali Linux
# NOTE: You will need to subscribe to use Kali Linux on the AWS marketplace BEFORE running terraform apply
# If not, terraform will throw an error message that will show where you can subscribe
data "aws_ami" "kali-ec2-ami" {
  most_recent = true             # Grab the most recent image id
  owners      = ["679593333241"] # The account id that owns the image (which belongs to Kali Linux)
  
  # Find the LATEST Amazon Image that contains kali-rolling-amd64-* and the virtualization type is hvm
  filter {
    name   = "name"
    values = ["kali-rolling-amd64*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}