output "droplets_ips" {
  value = digitalocean_droplet.droplet[*].ipv4_address
}

output "loadbalancer_ip" {
  value = digitalocean_loadbalancer.public.ip
}