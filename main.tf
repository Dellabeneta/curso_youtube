#três primeiros blocos básicos para acesso e comunicação com o provider.
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

#inserindo chave pública no servidor para acesso posterior.
resource "digitalocean_ssh_key" "curso" {
  name       = "curso"
  public_key = file("C:/Users/Administrador/.ssh/id_rsa.pub")
}

#provisionamento do load balancer.
resource "digitalocean_loadbalancer" "public" {
  name   = "loadbalancer"
  region = "nyc3"

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

  droplet_ids = [digitalocean_droplet.droplet1.id, digitalocean_droplet.droplet2.id]
}


#provisionamento do primeiro servidor.
resource "digitalocean_droplet" "droplet1" {
  name   = "webserver-1"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-20-04-x64"
  region = "nyc3"

  ssh_keys = [digitalocean_ssh_key.curso.id]

    /*
    connection {
    host        = digitalocean_droplet.droplet1.ipv4_address
    type        = "ssh"
    user        = "root"
    private_key = file("C:/Users/Administrador/.ssh/id_rsa")
    }
    
    provisioner "remote-exec" {
    inline = ["sleep 20", "apt install nginx -y",
              "sleep 20", "echo '${digitalocean_droplet.droplet1.name}' >> /var/www/html/index.nginx-debian.html"]              
    }
    */
}

#provisionamento do segundo servidor.
resource "digitalocean_droplet" "droplet2" {
  name   = "webserver-2"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-20-04-x64"
  region = "nyc3"

  ssh_keys = [digitalocean_ssh_key.curso.id]

    /*
    connection {
    host        = digitalocean_droplet.droplet2.ipv4_address
    type        = "ssh"
    user        = "root"
    private_key = file("C:/Users/Administrador/.ssh/id_rsa")
    }
      
    provisioner "remote-exec" {
    inline = ["sleep 20", "apt install nginx -y",
              "sleep 20", "echo '${digitalocean_droplet.droplet2.name}' >> /var/www/html/index.nginx-debian.html"]              
    }
    */ 
}


#imprimindo em tela o valor dos IPs dos servidores.
output "droplet1_ip" {
  value = digitalocean_droplet.droplet1.ipv4_address
}

output "droplet2_ip" {
  value = digitalocean_droplet.droplet2.ipv4_address
}

#imprimindo em tela o valor dos IDs dos servidores.
output "droplet1_id" {
  value = digitalocean_droplet.droplet1.id
}

output "droplet2_id" {
  value = digitalocean_droplet.droplet2.id
}

#imprimindo em tela o valor do IP do load balancer.
output "public" {
  value = digitalocean_loadbalancer.public.ip
}
