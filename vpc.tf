resource "aws_vpc" "ebilling-vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} VPC"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-vpc"
    yor_trace = "0c5f2206-a255-496a-a9f2-69cc079262db"
  }
}
#Internet Gateway
resource "aws_internet_gateway" "ebilling-internet-gateway" {
  vpc_id = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Internet Gateway"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-internet-gateway"
    yor_trace = "cfdfefcb-51bb-45dd-acf9-f6fa5969537b"
  }
}
#Public Subnets
resource "aws_subnet" "ebilling-public-subnet-1" {
  availability_zone = "${var.region}a"
  cidr_block        = "10.10.10.0/24"
  vpc_id            = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Public Subnet #1"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-1"
    yor_trace = "a2a39606-384b-48b7-b9a2-fc4cbdf2ed88"
  }
}
resource "aws_subnet" "ebilling-public-subnet-2" {
  availability_zone = "${var.region}b"
  cidr_block        = "10.10.20.0/24"
  vpc_id            = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Public Subnet #2"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-2"
    yor_trace = "1f4616b8-d005-4b61-8f69-0f6d4e6189aa"
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
    Name      = "ebilling ${random_string.bucket_suffix.result} Route Table for Public Subnet"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-route-table"
    yor_trace = "d4a41d7e-8b2d-4d95-8a42-eb3e9205ccc3"
  }
}
#Public Subnets Routing Associations
resource "aws_route_table_association" "ebilling-public-subnet-1-route-association" {
  subnet_id      = "${aws_subnet.ebilling-public-subnet-1.id}"
  route_table_id = "${aws_route_table.ebilling-public-subnet-route-table.id}"
}
resource "aws_route_table_association" "ebilling-public-subnet-2-route-association" {
  subnet_id      = "${aws_subnet.ebilling-public-subnet-2.id}"
  route_table_id = "${aws_route_table.ebilling-public-subnet-route-table.id}"
}