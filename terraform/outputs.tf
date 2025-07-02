output "cluster_name" {
    value = google_container_cluster.primary.name
}

output "kubeconfig" {
    value = <<EOT
Run the following command to get your kubeconfig:
    gcloud container clusters get-credentials self-healing-demo --region ${var.region} --project ${var.project_id}
EOT
}