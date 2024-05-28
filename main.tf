##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##-----------------------------------------------------------------------------
module "labels" {
  source      = "terraform-do-modules/labels/digitalocean"
  version     = "1.0.1"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}

##---------------------------------------------------------------------------------------------------------------
## Provides a DigitalOcean Load Balancer resource. This can be used to create, modify, and delete Load Balancers.
##---------------------------------------------------------------------------------------------------------------
#tfsec:ignore:digitalocean-compute-enforce-https ##  For testing we are used http entry_protocol 80, do not use in prod env.
resource "digitalocean_loadbalancer" "main" {
  count                            = var.enabled ? 1 : 0
  name                             = format("%s-lb", module.labels.id)
  region                           = var.region
  size                             = var.lb_size
  size_unit                        = var.size_unit
  algorithm                        = var.algorithm
  redirect_http_to_https           = var.enabled_redirect_http_to_https
  enable_proxy_protocol            = var.enable_proxy_protocol
  enable_backend_keepalive         = var.enable_backend_keepalive
  http_idle_timeout_seconds        = var.http_idle_timeout_seconds
  disable_lets_encrypt_dns_records = var.disable_lets_encrypt_dns_records
  project_id                       = var.project_id
  vpc_uuid                         = var.vpc_uuid
  droplet_ids                      = var.droplet_ids
  droplet_tag                      = var.droplet_tag

  dynamic "firewall" {
    for_each = var.firewall
    content {
      deny  = lookup(firewall.value, "deny", null)
      allow = lookup(firewall.value, "allow", null)
    }
  }

  dynamic "forwarding_rule" {
    for_each = var.forwarding_rule
    content {
      entry_port       = forwarding_rule.value.entry_port
      entry_protocol   = forwarding_rule.value.entry_protocol
      target_port      = forwarding_rule.value.target_port
      target_protocol  = forwarding_rule.value.target_protocol
      certificate_name = lookup(forwarding_rule.value, "certificate_name", null)
      tls_passthrough  = lookup(forwarding_rule.value, "tls_passthrough", false)
    }
  }

  dynamic "healthcheck" {
    for_each = var.healthcheck
    content {
      port                     = healthcheck.value.port
      protocol                 = healthcheck.value.protocol
      path                     = healthcheck.value.protocol == "tcp" ? null : lookup(healthcheck.value, "path", "/")
      check_interval_seconds   = healthcheck.value.check_interval_seconds
      response_timeout_seconds = healthcheck.value.response_timeout_seconds
      unhealthy_threshold      = healthcheck.value.unhealthy_threshold
      healthy_threshold        = healthcheck.value.healthy_threshold
    }
  }

  dynamic "sticky_sessions" {
    for_each = var.sticky_sessions
    content {
      type               = lookup(sticky_sessions.value, "type", "none")
      cookie_name        = lookup(sticky_sessions.value, "cookie_name", null)
      cookie_ttl_seconds = lookup(sticky_sessions.value, "cookie_ttl_seconds", null)
    }
  }
}
