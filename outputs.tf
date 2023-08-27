# -------
# OUTPUTS
# -------

# Example A
output "example_a_static_site_hostname" {
  description = "Static sites hostname for Example A."
  value       = "https://${azurerm_static_site.example_a.default_host_name}"
}

# Example B
output "example_b_static_site_hostnames" {
  description = "Static sites hostname for Example B."
  value = { for k,v in azurerm_static_site.example_b : k => v.default_host_name }
}

# Example C
output "example_c_static_site_hostnames" {
  description = "Static sites hostname for Example C."
  value = { for k,v in azurerm_static_site.example_c : k => v.default_host_name }
}
