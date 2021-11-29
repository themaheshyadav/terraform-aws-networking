output "vpc_id" {
  value = join("", aws_vpc.my_vpc.*.id)
}
output "aws_eip" {
  value = join("", aws_subnet.my_subnet.*.id)
}