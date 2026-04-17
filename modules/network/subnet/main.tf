resource "aws_subnet" "this" {
  vpc_id     = var.vpc_id
  availability_zone = var.az
  cidr_block = var.subnet_cidr
}