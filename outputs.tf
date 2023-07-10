# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------
output "id" {
  value       = join("", digitalocean_loadbalancer.main[*].id)
  description = "The ID of the Load Balancer."
}
output "ip" {
  value       = join("", digitalocean_loadbalancer.main[*].ip)
  description = "The ip of the Load Balancer."
}
output "urn" {
  value       = join("", digitalocean_loadbalancer.main[*].urn)
  description = "The uniform resource name for the Load Balancer."
}
