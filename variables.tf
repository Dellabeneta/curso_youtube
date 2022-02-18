variable "region" {
  default = "nyc3"
}

variable "server_size" {
  default = "s-1vcpu-1gb"
}

variable "server_image" {
  default = "ubuntu-20-04-x64"
}

variable "lb_name" {
  default = "loadbalancer"
}

variable "cluster_name" {
  default = "postgres-cluster"
}

variable "cluster_engine" {
  default = "pg"
}

variable "cluster_version" {
  default = "11"
}

variable "cluster_size" {
  default = "db-s-1vcpu-1gb"
}

variable "cluster_node_count" {
  default = 1
}
