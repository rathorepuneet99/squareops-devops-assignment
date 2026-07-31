# SquareOps DevOps Assignment

## 📌 Project Overview

This project demonstrates the deployment of a distributed voting application on a **Kubernetes cluster** using **Kind**, **Helm**, and **GitHub Actions**.

The solution follows DevOps best practices by automating the complete deployment lifecycle—from cluster creation to application deployment—using a **bootstrap script**, Helm charts, and a CI/CD pipeline.

The application is built using a microservices architecture consisting of a Vote application, Redis, Worker, PostgreSQL, and Result application.

---

# 🏗️ End-to-End Architecture

```text
                    Developer
                        │
                        ▼
               GitHub Repository
                        │
                        ▼
             GitHub Actions Workflow
                        │
                        ▼
                 Helm Deployment
                        │
                        ▼
                 bootstrap.sh
                        │
        ┌───────────────┴────────────────┐
        │                                │
        ▼                                ▼
  Create Kind Cluster         Install NGINX Ingress
        │
        ▼
+---------------------------------------------------------------+
|                 Kubernetes Cluster (Kind)                     |
|                Namespace : squareops                          |
|                                                               |
|  Vote App ─────► Redis ─────► Worker ─────► PostgreSQL        |
|      ▲                                         │              |
|      │                                         ▼              |
|      └──────────────────── Result App ◄────────┘              |
|                                                               |
| Services                                                      |
| • Vote (NodePort)                                             |
| • Result (NodePort)                                           |
| • Redis (ClusterIP)                                           |
| • PostgreSQL (Headless Service)                               |
+---------------------------------------------------------------+
```

---

# 🚀 Features

- Automated Kubernetes Cluster Provisioning using **Kind**
- Automated Environment Setup using **bootstrap.sh**
- Helm-based Kubernetes Deployment
- GitHub Actions CI/CD Pipeline
- Redis Message Queue
- PostgreSQL StatefulSet for Persistent Storage
- NGINX Ingress Controller
- Kubernetes Deployments & Services
- Infrastructure Automation
- Deployment Verification
- End-to-End Containerized Microservices

---

# 🏗️ Application Components

| Component | Purpose |
|-----------|---------|
| Vote | Frontend application used to cast votes |
| Redis | Temporary message queue |
| Worker | Reads votes from Redis and stores them into PostgreSQL |
| PostgreSQL | Persistent relational database |
| Result | Displays live voting results |

---

# 🛠️ Technologies Used

- Docker
- Kubernetes
- Kind
- Helm
- GitHub Actions
- PostgreSQL
- Redis
- NGINX Ingress Controller
- Git
- Linux

---

# 📁 Project Structure

```text
squareops-devops-assignment/
│
├── bootstrap.sh
│
├── helm/
│   └── voting-app/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
│            ├── namespace.yaml
│            ├── ingress.yaml
│            ├── secret.yaml
│            ├── vote-deployment.yaml
│            ├── vote-service.yaml
│            ├── worker-deployment.yaml
│            ├── redis-deployment.yaml
│            ├── redis-service.yaml
│            ├── postgres-statefulset.yaml
│            ├── postgres-service.yaml
│            ├── result-deployment.yaml
│            └── result-service.yaml
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
└── README.md
```

---

# ⚙️ Bootstrap Automation

The project includes a **bootstrap.sh** script that automates the complete Kubernetes environment setup.

Running a single command:

```bash
./bootstrap.sh
```

performs the following tasks automatically:

- Creates the Kind Kubernetes cluster
- Installs the NGINX Ingress Controller
- Waits until the Ingress Controller is ready
- Creates the required Kubernetes namespace
- Deploys the application using Helm
- Waits for Deployments and StatefulSet rollout
- Verifies that the application has been successfully deployed

This automation eliminates repetitive manual setup and ensures a consistent deployment process.

---

# ⛵ Helm Deployment

The application is packaged using a reusable Helm chart.

The Helm chart manages:

- Deployments
- Services
- StatefulSet
- Secrets
- Namespace
- Ingress

Application configuration is centralized inside:

```text
values.yaml
```

This allows images, ports, replica counts, resource limits, and deployment parameters to be managed from a single configuration file.

---

# 🔄 GitHub Actions CI/CD Pipeline

The repository includes a GitHub Actions workflow that automates application deployment.

The pipeline performs the following steps:

1. Checkout Repository
2. Configure Kubernetes Access
3. Create Namespace (if required)
4. Deploy or Upgrade Helm Release
5. Wait for Deployments
6. Wait for PostgreSQL StatefulSet
7. Verify Successful Deployment

This provides a reliable, repeatable, and automated deployment workflow.

---

# 🚀 Deployment Steps

## Clone the Repository

```bash
git clone <repository-url>

cd squareops-devops-assignment
```

---

## Run Bootstrap Script

```bash
./bootstrap.sh
```

---

## Verify Deployment

Check Pods

```bash
kubectl get pods -n squareops
```

Check Services

```bash
kubectl get svc -n squareops
```

Check Ingress

```bash
kubectl get ingress -n squareops
```

Check StatefulSet

```bash
kubectl get statefulset -n squareops
```

---

# 🌐 Access the Application

Vote Application

```
http://localhost:8082
```

Result Application

```
http://localhost:8081
```

Cast votes using the Vote application and observe live updates on the Result application.

---

# 📊 Kubernetes Resources

| Resource | Kubernetes Object |
|----------|-------------------|
| Vote | Deployment |
| Worker | Deployment |
| Redis | Deployment |
| PostgreSQL | StatefulSet |
| Result | Deployment |
| Services | ClusterIP & NodePort |
| Ingress | NGINX Ingress |

---

# 🔍 Troubleshooting

Useful Kubernetes commands:

### Check Pods

```bash
kubectl get pods -n squareops
```

### Describe a Pod

```bash
kubectl describe pod <pod-name> -n squareops
```

### View Logs

```bash
kubectl logs <pod-name> -n squareops
```

### Check Services

```bash
kubectl get svc -n squareops
```

### Check StatefulSet

```bash
kubectl get statefulset -n squareops
```

### Check Ingress

```bash
kubectl get ingress -n squareops
```

---

# 🎯 Learning Outcomes

This project demonstrates practical experience with:

- Kubernetes Cluster Provisioning
- Helm Chart Development
- Kubernetes Deployments
- Stateful Applications
- Kubernetes Networking
- NGINX Ingress
- Infrastructure Automation
- GitHub Actions CI/CD
- Container Orchestration
- Microservices Deployment
- Kubernetes Troubleshooting
- DevOps Best Practices

---

# 📌 Key Highlights

- Automated cluster creation using Kind
- One-command environment setup using `bootstrap.sh`
- Reusable Helm charts
- Automated CI/CD using GitHub Actions
- Persistent PostgreSQL StatefulSet
- Redis-based asynchronous processing
- Kubernetes-native deployment
- Production-style project structure
- Infrastructure automation and deployment verification

---

# 👨‍💻 Author

**Puneet Rathore**

**PG Diploma in Big Data Analytics (CDAC)**

### Skills

Docker • Kubernetes • Helm • GitHub Actions • AWS • Terraform • Jenkins • Python • Linux • Git