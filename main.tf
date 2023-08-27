# ---------
# PROVIDERS
# ---------

# Azure
provider "azurerm" {
  features {}
}

# Time
provider "time" {}


# ----
# DATA
# ----
data "azurerm_dns_zone" "main" {
  name                = var.dns_zone
  resource_group_name = var.dns_zone_resource_group_name
}

# --------------
# RESOURCE GROUP
# --------------

# Create resource group
resource "azurerm_resource_group" "main" {
  name     = "rg-example-lab"
  location = var.location
}

# --------------------------------------
# EXAMPLE A: STATIC SITE WITH CUSTOM DNS
# --------------------------------------

# Create static web site
resource "azurerm_static_site" "example_a" {
  name                = "stapp-example-a-lab"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

# Create DNS record
resource "azurerm_dns_cname_record" "example_a" {
  name                = var.dns_record
  resource_group_name = var.dns_zone_resource_group_name
  ttl                 = 300
  zone_name           = var.dns_zone
  record              = azurerm_static_site.example_a.default_host_name
}

# Sleep after creating the DNS record
resource "time_sleep" "dns" {
  depends_on      = [azurerm_dns_cname_record.example_a]
  create_duration = "10s"
}

# Configure custom domain name for static site
resource "azurerm_static_site_custom_domain" "example_a" {
  static_site_id  = azurerm_static_site.example_a.id
  domain_name     = "${var.dns_record}.${var.dns_zone}"
  validation_type = "cname-delegation"

  depends_on = [time_sleep.dns]
}


# ---------------------------------
# EXAMPLE B: STATIC SITE WITH COUNT
# ---------------------------------

# Create static web site
resource "azurerm_static_site" "example_b" {
  count = 3

  name                = "stapp-example-b-${count.index + 1}-lab"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}


# ------------------------------------
# EXAMPLE C: STATIC SITE WITH FOR_EACH
# ------------------------------------

locals {
  sites = [
    "app1",
    "app2",
    "app3"
  ]
}

# Create static web site
resource "azurerm_static_site" "example_c" {
  for_each = toset(local.sites)

  name                = "stapp-example-c-${each.key}-lab"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}
