#!/bin/bash

set -euo pipefail

echo "📦 Finding self-healing pods..."
pods=$(kubectl get pods -l app=self-healing-app -o jsonpath="{.items[*].metadata.name}")

if [ -z "$pods" ]; then
  echo "❌ No pods found with label app=self-healing"
  exit 1
fi

echo "✅ Found pods:"
for pod in $pods; do
  echo " - $pod"
done

echo

port_base=8081
count=0

for pod in $pods; do
  port=$((port_base + count))
  echo "🌐 Port-forwarding $pod to localhost:$port..."

  # Start port-forward in background
  kubectl port-forward "$pod" $port:8000 > /dev/null 2>&1 &
  pf_pid=$!

  # Give port-forward time to start
  sleep 2

  echo "📬 Sending POST /ready to $pod..."
  curl -X POST "http://localhost:$port/ready" || echo "❌ Request failed"

  # Kill the port-forward process
  kill $pf_pid
  wait $pf_pid 2>/dev/null || true

  echo "✅ $pod marked as ready"
  echo

  count=$((count + 1))
done

echo "🎉 All pods toggled ready."
