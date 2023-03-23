variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "ami_id" {
  type = map
  default = {
    ap-south-1    = "ami-05afd67c4a44cc983"
  }
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = "feb"
}
