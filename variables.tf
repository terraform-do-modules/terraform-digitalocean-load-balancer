#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "terraform-do-modules"
  description = "ManagedBy, eg 'terraform-do-modules' or 'hello@clouddrove.com'"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources."
}

variable "lb_size" {
  type        = string
  default     = "lb-small"
  description = "The size of the Load Balancer. It must be either lb-small, lb-medium, or lb-large. Defaults to lb-small. Only one of size or size_unit may be provided."
}

variable "size_unit" {
  type        = number
  default     = 1
  description = "The size of the Load Balancer. It must be in the range (1, 100). Defaults to 1. Only one of size or size_unit may be provided."
}

variable "enabled_redirect_http_to_https" {
  type        = bool
  default     = false
  description = "A boolean value indicating whether HTTP requests to the Load Balancer on port 80 will be redirected to HTTPS on port 443. Default value is false."
}

variable "enable_proxy_protocol" {
  type        = bool
  default     = false
  description = "A boolean value indicating whether PROXY Protocol should be used to pass information from connecting client requests to the backend service. Default value is false."
}

variable "enable_backend_keepalive" {
  type        = bool
  default     = false
  description = "A boolean value indicating whether HTTP keepalive connections are maintained to target Droplets. Default value is false."
}

variable "http_idle_timeout_seconds" {
  type        = number
  default     = null
  description = "Specifies the idle timeout for HTTPS connections on the load balancer in seconds."
}

variable "disable_lets_encrypt_dns_records" {
  type        = bool
  default     = false
  description = "A boolean value indicating whether to disable automatic DNS record creation for Let's Encrypt certificates that are added to the load balancer. Default value is false."
}

variable "project_id" {
  type        = string
  default     = null
  description = "The ID of the project that the load balancer is associated with. If no ID is provided at creation, the load balancer associates with the user's default project."
}

variable "vpc_uuid" {
  type        = string
  default     = ""
  description = "The ID of the VPC where the load balancer will be located."
}

variable "droplet_ids" {
  type        = list(string)
  default     = []
  description = "A list of the IDs of each droplet to be attached to the Load Balancer."
}

variable "droplet_tag" {
  type        = string
  default     = null
  description = "The name of a Droplet tag corresponding to Droplets to be assigned to the Load Balancer."
}

variable "region" {
  type        = string
  default     = "blr-1"
  description = "The region to create VPC, like ``london-1`` , ``bangalore-1`` ,``newyork-3`` ``toronto-1``. "
}

variable "forwarding_rule" {
  type        = list(any)
  default     = []
  description = "List of objects that represent the configuration of each forwarding_rule."
}

variable "healthcheck" {
  type        = list(any)
  default     = []
  description = "List of objects that represent the configuration of each healthcheck."
}

variable "sticky_sessions" {
  type        = list(any)
  default     = []
  description = "List of objects that represent the configuration of each healthcheck."
}

variable "firewall" {
  type        = list(any)
  default     = []
  description = "List of objects that represent the configuration of each healthcheck."
}
