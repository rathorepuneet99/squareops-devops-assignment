#!/bin/bash

set -e

echo "=============================================="
echo "SquareOps DevOps Assignment Bootstrap"
echo "=============================================="

# Check required tools
for cmd in docker kind kubectl helm; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: $cmd is not installed or not in PATH."
        exit 1
    fi
done

# Create Kind Cluster
if kind get clusters | grep -q "^voting-app$"; then
    echo "Kind cluster already exists."
else
    echo "Creating Kind cluster..."
    kind create cluster --name voting-app --image kindest/node:v1.31.4
fi

# Install NGINX Ingress Controller
echo ""
echo "Installing NGINX Ingress Controller..."

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "Waiting for Ingress Controller..."

# Wait until the controller pod is created
until kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller 2>/dev/null | grep -q controller; do
    sleep 2
done

# Wait until it becomes Ready
kubectl wait \
  --namespace ingress-nginx \
  --for=condition=Ready pod \
  -l app.kubernetes.io/component=controller \
  --timeout=600s

# Deploy Helm Chart
echo ""
echo "Deploying application..."

helm upgrade --install voting-app \
  ./helm/voting-app \
  --namespace squareops \
  --create-namespace \
  --wait \
  --timeout 600s

# Wait for Pods
echo ""
echo "Waiting for application pods..."

kubectl wait \
  --namespace squareops \
  --for=condition=Ready pod \
  --all \
  --timeout=600s

echo ""
echo "=============================================="
echo "Application Deployed Successfully!"
echo "=============================================="

echo ""
kubectl get svc -n squareops

echo ""
echo "Vote App   : http://localhost:31000"
echo "Result App : http://localhost:31001"