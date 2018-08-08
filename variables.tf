#
# Variables Configuration
#

variable "cluster-name" {
  default = "terraform-eks"
  type    = "string"
}

variable "nodes-instance-type" {
  default = "m4.large" # 2 vCPU, 8Gb RAM
  type    = "string"
}

variable "nodes-count" {
  default = "1"
  type    = "string"
}
