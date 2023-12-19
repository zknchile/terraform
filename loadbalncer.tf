variable "load_balancer_shape_details_maximum_bandwidth_in_mbps" {
  default = 10
}

variable "load_balancer_shape_details_minimum_bandwidth_in_mbps" {
  default = 10
}

resource "oci_load_balancer" "flex_lb_windows" {
  shape          = "flexible"
  compartment_id = var.compartment_id

  subnet_ids = [
    "ocid1.subnet.oc1.sa-santiago-1.aaaaaaaaszloosl7wbpslxfvez6bh3fryg4ylmxwniiisvgmbcgofl42wwaq"
  ]

  shape_details {
    #Required
    maximum_bandwidth_in_mbps = var.load_balancer_shape_details_maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.load_balancer_shape_details_minimum_bandwidth_in_mbps
  }

  display_name = "flex_lb_windows"
}

resource "oci_load_balancer_backend_set" "flex_lb_windows" {
  name             = "flex_lb_windows"
  load_balancer_id = oci_load_balancer.flex_lb_windows.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}

resource "oci_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = oci_load_balancer.flex_lb_windows.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.flex_lb_windows.name
  #hostname_names           = [oci_load_balancer_hostname.test_hostname1.name]
  port                     = 80
  protocol                 = "HTTP"
  #rule_set_names           = [oci_load_balancer_rule_set.test_rule_set.name]

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}

resource "oci_load_balancer_backend" "lb-be1" {
  load_balancer_id = oci_load_balancer.flex_lb_windows.id
  backendset_name  = oci_load_balancer_backend_set.flex_lb_windows.name
  ip_address       = oci_core_instance.generated_oci_core_instance.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

output "lb_public_ip" {
  value = [oci_load_balancer.flex_lb_windows.ip_address_details]
}