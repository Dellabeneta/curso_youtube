resource "digitalocean_certificate" "certlink" {
  name       = "certlink"
  type       = "lets_encrypt"
  domains    = ["dellabeneta.link"]
  depends_on = [digitalocean_domain.link]
}