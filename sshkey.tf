resource "digitalocean_ssh_key" "curso" {
  name       = "curso"
  public_key = file("C:/Users/Administrador/.ssh/id_rsa.pub")
}