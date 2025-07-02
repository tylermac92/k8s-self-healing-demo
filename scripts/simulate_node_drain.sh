#!/bin/bash

set -euo pipefail

echo "Getting a node in the cluster..."
NODE=$(kubectl get nodes -o jsonpath="{.items[0].metadata.name}")

echo "Cordoning node $NODE..."
kubectl cordon "$NODE"

echo "Draining node $NODE..."
kubectl drain "$NODE" \
  --ignore-daemonsets \
  --delete-emptydir-data \
  --force

echo "Watching pods get rescheduled..."
kubectl get pods -l app=self-healing-app -w