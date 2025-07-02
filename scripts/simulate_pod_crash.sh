#!/bin/bash

set -euo pipefail

echo "Running mark-all-ready.sh to ensure all pods are Ready..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/mark-all-ready.sh"

echo "Finding a running pod from the self-healing deployment..."
POD=$(kubectl get pods -l app=self-healing-app -o jsonpath="{.items[0].metadata.name}")

echo "Port-forwarding to pod: $POD"
kubectl port-forward "$POD" 8080:8000 > /dev/null 2>&1 &
PF_PID=$!

sleep 2

echo "Triggering pod failure by POSTing to /fail..."
curl -X POST http://localhost:8080/fail || echo "Failed to contact app"

echo "Killing port-forward..."
kill $PF_PID
wait $PF_PID 2>/dev/null || true

echo "Watching for pod restart..."
kubectl get pod "$POD" -w