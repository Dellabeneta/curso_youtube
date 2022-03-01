
resource "digitalocean_droplet" "droplet" {
  name     = "webserver-${count.index}"
  size     = var.servers_size
  image    = var.servers_image
  region   = var.region
  count    = 2
  ssh_keys = [digitalocean_ssh_key.curso.id]
  vpc_uuid = digitalocean_vpc.vpc.id
  tags = [ "webserver" ]
  

  connection {
    host        = self.ipv4_address
    type        = "ssh"
    user        = "root"
    private_key = file("C:/Users/Administrador/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
    "sleep 20",
    "apt install apache2 -y",
    "sleep 10",
    "echo webserver-'${count.index}' > /var/www/html/index.html"
    ]
  }
}