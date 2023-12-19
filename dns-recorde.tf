resource "oci_dns_rrset" "rrset-a" {
  zone_name_or_id = var.zone_name_or_id
  domain          = var.domain
  rtype           = "A"

  items {
    domain = "windowsinstace.prestadoreschile.cl"
    rtype  = "A"
    rdata  = oci_load_balancer.flex_lb_windows.ip_address_details[0].ip_address
    ttl    = 3600
  }
}