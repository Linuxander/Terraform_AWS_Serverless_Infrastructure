locals {
  allowed_ips = [for ip in split("\n", trimspace(file("${path.module}/data/allowed_ips.txt"))) : ip]
}