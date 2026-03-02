# Infrastructure as Code for Aman Compass

This directory contains all infrastructure definitions for deploying Aman Compass on Azure.

## Structure

- `terraform/`: Terraform configurations for provisioning Azure resources (AKS, databases, networking, etc.)
- `k8s/`: Kubernetes manifests for deploying microservices, AI layer, and dashboard on AKS
- `azure/`: ARM templates and Azure CLI scripts (optional)
- `ci-cd/`: CI/CD pipeline configurations (GitHub Actions workflows)

## Prerequisites

- Azure CLI installed and authenticated
- Terraform (≥1.3)
- kubectl
- Access to an Azure subscription (UAE regions preferred)

## Quick Start

1. Navigate to `terraform/`:
   ```bash
   cd terraform
```

1. Initialize Terraform:
   ```bash
   terraform init
   ```
2. Select the appropriate workspace (dev/staging/prod):
   ```bash
   terraform workspace new dev
   terraform workspace select dev
   ```
3. Apply the configuration:
   ```bash
   terraform apply -var-file="environments/dev.tfvars"
   ```
4. Once infrastructure is ready, deploy Kubernetes manifests:
   ```bash
   cd ../k8s
   kubectl apply -f namespace.yaml
   kubectl apply -f configmap.yaml
   kubectl apply -f secrets.yaml   # ensure secrets are created first
   kubectl apply -f deployments/
   kubectl apply -f services/
   ```

For detailed instructions, see the main Deployment Guide.
