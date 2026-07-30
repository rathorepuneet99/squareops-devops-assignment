# SquareOps DevOps Assignment

## Overview

This repository contains my solution for the **SquareOps DevOps Take-Home Assignment**.

The project demonstrates the deployment and automation of a distributed voting application using **Docker Compose**, **Kubernetes**, **Helm**, and **GitHub Actions CI/CD**.

The solution includes containerization, Kubernetes deployment, Helm packaging, PostgreSQL persistence using StatefulSets, and an automated CI/CD pipeline.

---

# Project Architecture

```
                GitHub Repository
                        │
                        ▼
               GitHub Actions CI/CD
                        │
      ┌─────────────────┴──────────────────┐
      │                                    │
      ▼                                    ▼
 Build Docker Image               Helm Deployment
      │                                    │
      ▼                                    ▼
 Push to DockerHub                 Kind Kubernetes Cluster
                                            │
                                            ▼
        ┌──────────────┬───────────────┬──────────────┐
        │              │               │              │
        ▼              ▼               ▼              ▼
      Vote App      Redis          Worker       PostgreSQL
                                             (StatefulSet)
```

---

# Technologies Used

- Docker
- Docker Compose
- Kubernetes
- Kind
- Helm
- GitHub Actions
- Python
- Flask
- Redis
- PostgreSQL

---

# Repository Structure

```
squareops-devops-assignment
│
├── .github/
│   └── workflows/
│       └── ci-cd.yml
│
├── helm/
│   └── voting-app/
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── values-dev.yaml
│       ├── values-staging.yaml
│       └── templates/
│
├── healthchecks/
│
├── vote/
│
├── docker-compose.yml
│
└── README.md
```

---

# Running the Application using Docker Compose

Clone the repository

```bash
git clone https://github.com/rathorepuneet99/squareops-devops-assignment.git
cd squareops-devops-assignment
```

Start the application

```bash
docker compose up --build
```

Application URLs

| Service | URL |
|----------|-----|
| Vote App | http://localhost:8082 |
| Result App | http://localhost:8081 |

---

# Kubernetes Deployment

Create a Kind cluster

```bash
kind create cluster --name voting-app
```

Install the Helm chart

```bash
helm install voting-app ./helm/voting-app \
-n squareops \
--create-namespace
```

Verify resources

```bash
kubectl get all -n squareops
```

Verify StatefulSet

```bash
kubectl get statefulsets -n squareops
```

Verify Persistent Volume Claim

```bash
kubectl get pvc -n squareops
```

---

# Helm

Validate Helm chart

```bash
helm lint ./helm/voting-app
```

Install

```bash
helm install voting-app ./helm/voting-app \
-n squareops \
--create-namespace
```

Upgrade

```bash
helm upgrade voting-app ./helm/voting-app \
-n squareops
```

Uninstall

```bash
helm uninstall voting-app -n squareops
```

---

# CI/CD Pipeline

The GitHub Actions workflow automatically performs the following steps whenever changes are pushed to the **vote/** directory.

- Checkout repository
- Setup Python
- Install Python dependencies
- Run Flake8 code linting
- Install kubeconform
- Validate Kubernetes manifests
- Build Docker image
- Login to DockerHub
- Push Docker image
- Create Kind cluster
- Install Helm
- Deploy the application
- Wait for all pods
- Execute smoke tests

Workflow location

```
.github/workflows/ci-cd.yml
```

---

# Helm Features

The Helm chart includes

- PostgreSQL StatefulSet
- Persistent Volume Claim
- Headless Service
- Kubernetes Secrets
- ConfigMaps
- Resource Requests
- Resource Limits
- Liveness Probes
- Readiness Probes
- Environment-specific values files

---

# Environment Configuration

Development

```
values-dev.yaml
```

Staging

```
values-staging.yaml
```

Default

```
values.yaml
```

---

# Useful Commands

Check pods

```bash
kubectl get pods -n squareops
```

Check services

```bash
kubectl get svc -n squareops
```

Check deployments

```bash
kubectl get deployments -n squareops
```

Check StatefulSets

```bash
kubectl get statefulsets -n squareops
```

Describe pod

```bash
kubectl describe pod <pod-name> -n squareops
```

View logs

```bash
kubectl logs <pod-name> -n squareops
```

---

# Verification

Validate Helm chart

```bash
helm lint ./helm/voting-app
```

Run Docker Compose

```bash
docker compose up --build
```

Deploy using Helm

```bash
helm install voting-app ./helm/voting-app \
-n squareops \
--create-namespace
```

Verify deployment

```bash
kubectl get all -n squareops
```

---

# Future Improvements

- HTTPS Ingress with TLS
- Horizontal Pod Autoscaler
- Prometheus Monitoring
- Grafana Dashboards
- ArgoCD GitOps Deployment
- Multi-environment Helm Releases

---

# Author

**Puneet Rathore**

GitHub: https://github.com/rathorepuneet99

---

## Assignment Highlights

✔ Docker Compose Deployment

✔ Kubernetes Deployment

✔ PostgreSQL StatefulSet

✔ Persistent Storage

✔ Helm Chart

✔ Environment-specific Values

✔ GitHub Actions CI/CD

✔ DockerHub Image Publishing

✔ Automated Helm Deployment

✔ Smoke Testing

✔ Infrastructure Automation
