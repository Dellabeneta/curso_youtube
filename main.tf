provider "digitalocean" {
  token = var.do_token
}

variable "do_token" {}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

resource "digitalocean_ssh_key" "curso" {
  name       = "curso"
  public_key = file("C:/Users/Administrador/.ssh/id_rsa.pub")
}

resource "digitalocean_loadbalancer" "public" {
  name   = var.lb_name
  region = var.region

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = digitalocean_droplet.droplet[*].id
}

resource "digitalocean_droplet" "droplet" {
  name   = "webserver-${count.index}"
  size   = var.servers_size
  image  = var.servers_image
  region = var.region
  ssh_keys = [digitalocean_ssh_key.curso.id]

  
  connection {
    host        = self.ipv4_address
    type        = "ssh"
    user        = "root"
    private_key = file("C:/Users/Administrador/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = ["sleep 20", "apt install apache2 -y",
    "sleep 20", "echo $HOSTNAME > /var/www/html/index.html"]
  }
  
  count = 2
}

resource "digitalocean_database_cluster" "postgres" {
  name       = var.cluster_name
  engine     = var.cluster_engine
  version    = var.cluster_version
  size       = var.cluster_size
  region     = var.region
  node_count = var.cluster_node_count
}

output "droplets" {
  value = digitalocean_droplet.droplet[*].ipv4_address
}

output "public" {
  value = digitalocean_loadbalancer.public.ip
}