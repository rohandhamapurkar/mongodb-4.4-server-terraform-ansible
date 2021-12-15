variable "do_token" {
	type        = string
  	description = "personal access token for digital ocean account"
}

variable "mongodb_server_name" {
	type        = string
  	description = "MongoDB server name"
}

variable "mongodb_server_image" {
	type        = string
  	description = "MongoDB server distro image name"
}

variable "mongodb_server_size" {
	type        = string
  	description = "MongoDB server size specs"
}

variable "mongodb_vpc" {
	type        = string
  	description = "MongoDB server vpc name"
}

variable "mongodb_region" {
	type        = string
  	description = "MongoDB server region"
}

variable "mongodb_ssh_fingerprint" {
	type        = string
  	description = "MongoDB ssh key fingerprint"
}

variable "mongodb_firewall_name" {
	type        = string
  	description = "MongoDB firewall name"
}

variable "do_project_name" {
	type        = string
  	description = "Digital Ocean Project Name"
}