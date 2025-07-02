variable "project_id" {
    description = "GCP Project ID"
    type = string
}

variable "region" {
    description = "GCP region"
    type = string
    default = "us-east1"
}

variable "credentials_file" {
    description = "Path to GCP service account credentials"
    type = string
    default = "~/.gcp/credentials.json"
}