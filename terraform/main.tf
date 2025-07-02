terraform {
    required_version = ">= 1.12.0"

    required_providers {
        google = {
            source = "hashicorp/google"
            version = ">= 6.42.0"
        }
    }
}

provider "google" {
    project = var.project_id
    region = var.region
    credentials = file(var.credentials_file)
}

resource "google_container_cluster" "primary" {
    name = "self-healing-demo"
    location = var.region

    remove_default_node_pool = true
    initial_node_count = 1

    network = "default"
    subnetwork = "default"
}

resource "google_container_node_pool" "primary_nodes" {
    name = "primary-nodes"
    cluster = google_container_cluster.primary.name
    location = var.region

    node_count = 1

    node_config {
        machine_type = "e2-medium"
        disk_size_gb = 30
        oauth_scopes = [
            "https://www.googleapis.com/auth/cloud-platform"
        ]
    }
}