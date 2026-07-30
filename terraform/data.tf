################################################################################
# Availability Zones list out
################################################################################
data "aws_availability_zones" "available_1" {
  state = "available"
}
data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}