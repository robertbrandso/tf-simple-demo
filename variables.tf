# ------
# BASICS
# ------

variable "location" {
  description = "(Optional) Azure region where the resources should be created."
  type        = string
  default     = "westeurope"
}

# ---------
# EXAMPLE A
# ---------
variable "dns_record" {
  description = "(Required) DNS record which the site should be published as"
  type        = string
}

variable "dns_zone" {
  description = "(Required) Name of the DNS zone."
  type        = string
}

variable "dns_zone_resource_group_name" {
  description = "(Required) Name of the Resource Group where the DNS Zone exists."
  type        = string
}
