output "vpc_id" {
  value = join("", module.aws_vpc.*.vpc_id)
}
output "aws_eip" {
  value = join("", module.aws_vpc.*.aws_eip)
}