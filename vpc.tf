resource "aws_vpc" "ebilling-vpc" {
  cidr_block = "10.10.0.0/16"
  enable_dns_hostnames = true
  tags = {
      Name = "ebilling ${random_string.bucket_suffix.result} VPC"
      Stack = "${var.stack-name}"
      Scenario = "${var.scenario-name}"
  }
}
#Internet Gateway
resource "aws_internet_gateway" "ebilling-internet-gateway" {
  vpc_id = "${aws_vpc.ebilling-vpc.id}"
  tags = {
      Name = "ebilling ${random_string.bucket_suffix.result} Internet Gateway"
      Stack = "${var.stack-name}"
      Scenario = "${var.scenario-name}"
  }
}
#Public Subnets
resource "aws_subnet" "ebilling-public-subnet-1" {
  availability_zone = "${var.region}a"
  cidr_block = "10.10.10.0/24"
  vpc_id = "${aws_vpc.ebilling-vpc.id}"
  tags = {
      Name = "ebilling ${random_string.bucket_suffix.result} Public Subnet #1"
      Stack = "${var.stack-name}"
      Scenario = "${var.scenario-name}"
  }
}
resource "aws_subnet" "ebilling-public-subnet-2" {
  availability_zone = "${var.region}b"
  cidr_block = "10.10.20.0/24"
  vpc_id = "${aws_vpc.ebilling-vpc.id}"
  tags = {
      Name = "ebilling ${random_string.bucket_suffix.result} Public Subnet #2"
      Stack = "${var.stack-name}"
      Scenario = "${var.scenario-name}"
  }
}
#Public Subnet Routing Table
resource "aws_route_table" "ebilling-public-subnet-route-table" {
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.ebilling-internet-gateway.id}"
  }
  vpc_id = "${aws_vpc.ebilling-vpc.id}"
  tags = {
      Name = "ebilling ${random_string.bucket_suffix.result} Route Table for Public Subnet"
      Stack = "${var.stack-name}"
      Scenario = "${var.scenario-name}"
  }
}
#Public Subnets Routing Associations
resource "aws_route_table_association" "ebilling-public-subnet-1-route-association" {
  subnet_id = "${aws_subnet.ebilling-public-subnet-1.id}"
  route_table_id = "${aws_route_table.ebilling-public-subnet-route-table.id}"
}
resource "aws_route_table_association" "ebilling-public-subnet-2-route-association" {
  subnet_id = "${aws_subnet.ebilling-public-subnet-2.id}"
  route_table_id = "${aws_route_table.ebilling-public-subnet-route-table.id}"
}