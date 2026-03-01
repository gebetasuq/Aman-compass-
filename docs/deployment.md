# Aman Compass – Deployment Guide

This document provides comprehensive instructions for deploying all components of the Aman Compass platform across development, staging, and production environments.


## 1. Prerequisites

### 1.1 Required Accounts & Access
- **Azure Subscription** (UAE regions preferred)
- **Firebase Project** (for push notifications)
- **UAE PASS Developer Account** (for authentication)
- **Pinecone Account** (for vector database)
- **OpenAI / Azure OpenAI Access** (for GPT‑4)
- **GitHub Account** (for CI/CD)

### 1.2 Local Development Tools
- Git
- Docker & Docker Compose
- Flutter SDK (≥3.0)
- Node.js (≥18) + npm/yarn
- Python (≥3.10) + pip
- Terraform (≥1.3)
- kubectl
- Azure CLI


## 2. Environment Setup

### 2.1 Clone the Repository
```bash
git clone https://github.com/gebetasuq/aman-compass.git
cd aman-compass
```

2.2 Environment Variables

Each service requires its own .env file. Template files (.env.example) are provided in each service directory.

Copy and fill in your credentials:

```bash
cp microservices/auth-service/.env.example microservices/auth-service/.env
cp microservices/entity-service/.env.example microservices/entity-service/.env
# ... repeat for all services
cp ai-layer/.env.example ai-layer/.env
```

2.3 Firebase Configuration

1. Create a Firebase project at console.firebase.google.com.
2. Download google-services.json (Android) and GoogleService-Info.plist (iOS).
3. Place them in citizen-app/android/app/ and citizen-app/ios/Runner/ respectively.
4. Generate a service account key (Project Settings → Service Accounts) and save as firebase-service-account.json in microservices/alerts-service/.

---

3. Local Development Deployment

3.1 Running Dependencies with Docker Compose

Start required databases and message brokers:

```bash
docker-compose up -d postgres redis rabbitmq
```

3.2 Running Microservices

Each microservice can be run independently:

```bash
cd microservices/auth-service
npm install
npm run dev  # runs on http://localhost:3001
```

Repeat for other services (adjust ports as needed):

· entity-service: 3002
· geo-intelligence: 3003
· alert-notification: 3004
· civic-trend-engine: 3005
· predictive-analytics: 3006
· phishing-intelligence: 3007

3.3 Running AI Layer

```bash
cd ai-layer
python -m venv venv
source venv/bin/activate  # or `venv\Scripts\activate` on Windows
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

3.4 Running Citizen App

```bash
cd citizen-app
flutter pub get
flutter run
```

3.5 Running Government Dashboard

```bash
cd gov-dashboard
npm install
npm run dev  # runs on http://localhost:3000
```

4. Staging Deployment (Azure)

4.1 Infrastructure Provisioning with Terraform

```bash
cd infra/terraform
terraform init
terraform workspace new staging
terraform plan -var-file="environments/staging.tfvars"
terraform apply -var-file="environments/staging.tfvars"
```

4.2 Building and Pushing Docker Images

```bash
# Authenticate with Azure Container Registry
az acr login --name amancompassacr

# Build and push each service
cd microservices/auth-service
docker build -t amancompassacr.azurecr.io/auth-service:staging .
docker push amancompassacr.azurecr.io/auth-service:staging

# Repeat for all services and ai-layer
```

4.3 Deploying to AKS

```bash
# Get credentials for AKS cluster
az aks get-credentials --resource-group aman-compass-staging --name aman-compass-aks

# Apply Kubernetes manifests
cd infra/k8s/staging
kubectl apply -f namespace.yaml
kubectl apply -f configmap.yaml
kubectl apply -f secrets.yaml
kubectl apply -f deployments/
kubectl apply -f services/
```

4.4 Database Migrations

```bash
# Run migrations for PostgreSQL
cd data-layer/postgres
kubectl apply -f job-migrations.yaml
```

5. Production Deployment

5.1 Production Environment Preparation

· Ensure all staging tests pass
· Conduct security audit
· Perform load testing
· Review monitoring and alerting configuration

5.2 Production Infrastructure

```bash
cd infra/terraform
terraform workspace new production
terraform plan -var-file="environments/production.tfvars"
terraform apply -var-file="environments/production.tfvars"
```

5.3 Blue‑Green Deployment Strategy

The platform uses blue‑green deployments to minimize downtime:

```bash
# Deploy green environment
kubectl apply -f infra/k8s/production/green/

# Run smoke tests against green environment
./scripts/smoke-test.sh https://green.api.amancompass.ae

# Switch traffic to green
kubectl patch service api-gateway -p '{"spec":{"selector":{"version":"green"}}}'

# Keep blue for rollback if needed
```

5.4 Database Migrations

For production, use a migration tool with rollback capability:

```bash
kubectl apply -f infra/k8s/production/job-migrations.yaml
```

5.5 Monitoring & Alerting Setup

```bash
# Deploy Prometheus and Grafana
kubectl apply -f infra/k8s/monitoring/

# Configure alerts in Azure Monitor
az monitor metrics alert create ...
```

---

6. Environment Configuration Reference

6.1 Common Environment Variables

Variable Description Example
NODE_ENV Environment name production
PORT Service port 3001
DATABASE_URL PostgreSQL connection string postgresql://user:pass@host:5432/db
REDIS_URL Redis connection string redis://host:6379
JWT_SECRET Secret for JWT signing (secure random string)
UAE_PASS_CLIENT_ID UAE PASS OAuth client ID From UAE PASS portal
UAE_PASS_CLIENT_SECRET UAE PASS OAuth client secret From UAE PASS portal

6.2 AI Layer Variables

Variable Description Example
OPENAI_API_KEY OpenAI API key sk-...
AZURE_OPENAI_ENDPOINT Azure OpenAI endpoint https://your-resource.openai.azure.com/
AZURE_OPENAI_KEY Azure OpenAI key ...
PINECONE_API_KEY Pinecone API key ...
PINECONE_ENVIRONMENT Pinecone environment us-west1-gcp

6.3 Firebase Variables

Variable Description Location
FIREBASE_SERVICE_ACCOUNT Path to service account JSON microservices/alerts-service/firebase-service-account.json


7. CI/CD Pipelines

7.1 GitHub Actions Workflows

The repository includes the following workflows:

· frontend-ci.yml: Builds and tests citizen app and dashboard on PR.
· backend-ci.yml: Runs unit tests for all microservices.
· ai-ci.yml: Tests AI layer Python code.
· deploy-staging.yml: Deploys to staging on push to develop branch.
· deploy-production.yml: Deploys to production on release.

7.2 Manual Deployment

To trigger a manual deployment:

```bash
# From GitHub Actions tab, select workflow and run with parameters
# Or using gh CLI:
gh workflow run deploy-production.yml --ref main
```


8. Rollback Procedures

8.1 Application Rollback

For Kubernetes deployments:

```bash
# Rollback to previous deployment
kubectl rollout undo deployment/auth-service -n aman-compass

# Check status
kubectl rollout status deployment/auth-service -n aman-compass
```

8.2 Database Rollback

```bash
# Restore from backup
kubectl apply -f infra/k8s/production/job-restore.yaml
```

8.3 Full Environment Rollback via Terraform

```bash
cd infra/terraform
terraform workspace select production
terraform apply -var-file="environments/production.tfvars" -refresh-only
```

---

9. Troubleshooting

9.1 Common Issues

Issue Solution
Microservice fails to start Check .env file; verify database connectivity
Database connection refused Ensure PostgreSQL is running; check network policies
JWT validation fails Verify UAE PASS credentials; check JWT secret
AI service timeout Increase timeout in gateway; check vector DB latency
Push notifications not sending Verify Firebase service account; check topic subscriptions

9.2 Logs and Debugging

```bash
# View logs for a specific service
kubectl logs -f deployment/auth-service -n aman-compass

# Stream logs from all services
kubectl logs -l app=aman-compass -n aman-compass --tail=100 -f

# Access Azure Monitor logs
az monitor log-analytics query --workspace <workspace-id> --query "..."

# Remote debugging (development only)
kubectl port-forward deployment/auth-service 9229:9229 -n aman-compass
```

---

10. Security Considerations

· Never commit .env files to the repository.
· Rotate secrets regularly (JWT secret, API keys).
· Use managed identities in Azure instead of service principals where possible.
· Enable audit logging for all production services.
· Regularly update dependencies to patch security vulnerabilities.

---

11. Post‑Deployment Verification

After deployment, run the smoke tests:

```bash
./scripts/smoke-test.sh https://api.amancompass.ae
./scripts/smoke-test.sh https://dashboard.amancompass.ae
```

Verify monitoring dashboards are receiving data:

```bash
open https://grafana.amancompass.ae
```

---

12. Related Documentation

· Architecture Guide
· PDPL Compliance
· Roadmap

```
