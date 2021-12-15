// get the project information 
data "digitalocean_project" "prod" {
  name = var.do_project_name
}

// get the SSE default vpc 
data "digitalocean_vpc" "vpc" {
  name = var.mongodb_vpc
}