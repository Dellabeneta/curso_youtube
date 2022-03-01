resource "digitalocean_loadbalancer" "public" {
  name   = var.lb_name
  region = var.region
  vpc_uuid = digitalocean_vpc.vpc.id
  redirect_http_to_https = true

  forwarding_rule {
    entry_port      = 80
    entry_protocol  = "http"
    target_port     = 80
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port       = 443
    entry_protocol   = "https"
    target_port      = 80
    target_protocol  = "http"
    certificate_name = digitalocean_certificate.certlink.id
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = digitalocean_droplet.droplet[*].id
}