resource "digitalocean_firewall" "firewall" {
  name        = var.firewall_name
  droplet_ids = digitalocean_droplet.droplet[*].id

  inbound_rule {
    protocol                  = "tcp"
    port_range                = "80"
    source_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65355"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65355"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}


resource "digitalocean_database_firewall" "firewall_db" {
  cluster_id = digitalocean_database_cluster.postgres.id

  rule {
    type  = "ip_addr"
    value = "10.0.0.0/16"
  }
}
