![CI](https://github.com/tylermac92/k8s-self-healing-demo/actions/workflows/ci.yml/badge.svg)

Kubernetes Self-Healing Demo

🚀 Project Purpose

This project demonstrates Kubernetes self-healing capabilities by simulating application failures and node disruptions in a GKE cluster. It’s designed to showcase real-world resilience patterns including:

Liveness & readiness probes

Pod disruption budgets (PDB)

Horizontal Pod Autoscaling (HPA)

Automated recovery from failure

🛠️ Technologies Used

Google Kubernetes Engine (GKE) via Terraform

Kubernetes (Deployments, Probes, PDB, HPA)

Helm for templated manifests

FastAPI Python app with fail toggles

Docker and Docker Hub

GitHub Codespaces for development

⚙️ Setup Instructions

1. Clone the Repository

git clone https://github.com/tylermac92/k8s-self-healing-demo.git
cd k8s-self-healing-demo

2. Provision the GKE Cluster with Terraform

cd terraform
terraform init
terraform apply

3. Configure kubectl Access

gcloud container clusters get-credentials <cluster-name> --region <region> --project <project-id>

4. Deploy the Application via Helm

cd ../helm/self-healing-app
helm install self-healing-demo .

5. Confirm It’s Working

kubectl get pods
kubectl get svc

🧪 Failure Simulation Steps

✅ Simulate Application Crash

./scripts/simulate_pod_crash.sh

📌 What happens:

Sends POST request to /fail endpoint

Liveness probe fails

Kubernetes kills and restarts the pod automatically

✅ Simulate Node Disruption

./scripts/simulate_node_drain.sh

📌 What happens:

Selects a node and drains it

Kubernetes evicts pods

New pods are scheduled on other nodes

PDB ensures at least 1 pod remains available

🧹 Cleanup

cd terraform
terraform destroy

🙌 Credits

Built by Tyler MacPherson as part of a Kubernetes SRE/DevOps learning portfolio.
