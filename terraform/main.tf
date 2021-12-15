# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

// get a new floating ip in a region 
resource "digitalocean_floating_ip" "static_ip" {
  region = var.mongodb_region
}

// create the droplet
resource "digitalocean_droplet" "server" {
  image  = var.mongodb_server_image
  name   =	var.mongodb_server_name
  region = var.mongodb_region
  size   = var.mongodb_server_size
  monitoring = true
  vpc_uuid = data.digitalocean_vpc.mongodb_vpc.id
  ssh_keys = [var.mongodb_ssh_fingerprint]
}

// assign the floating ip to droplet
resource "digitalocean_floating_ip_assignment" "static_ip_assignment" {
  ip_address = digitalocean_floating_ip.static_ip.ip_address
  droplet_id = digitalocean_droplet.server.id
}

// assign the droplet to firewall 
resource "digitalocean_firewall" "firewall" {
  name = var.mongodb_firewall_name

  droplet_ids = [digitalocean_droplet.server.id]

  inbound_rule {
    protocol         = var.mongodb_inbound_rule.protocol
    port_range       = var.mongodb_inbound_rule.port_range
    source_addresses = var.mongodb_inbound_rule.source_addresses
  }


  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

// assign droplet to the SSE project
resource "digitalocean_project_resources" "barfoo" {
  project = data.digitalocean_project.prod.id
  resources = [
    digitalocean_droplet.server.urn
  ]
}