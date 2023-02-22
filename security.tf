# Defines what connections are allowed
resource "aws_security_group" "kali-sg" {
name = "allow-all-sg"
vpc_id = "${aws_vpc.IS565-February-VPC.id}"

# Only allow SSH connections
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  # Allow all outbound connections
  # Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

# Generates a private key that is used to make the key pair
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generates the key pair that is used to ssh into the instance
resource "aws_key_pair" "generated_key" {
  key_name   = "Kali EC2 Key"
  public_key = tls_private_key.example.public_key_openssh
}

# The terraform output by design does not show the key
# To get the key, use terraform output -raw private_key
output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}