resource "digitalocean_vpc" "vpc" {
  name     = "vpc"
  region   = "nyc1"
  ip_range = "10.0.0.0/16"
}