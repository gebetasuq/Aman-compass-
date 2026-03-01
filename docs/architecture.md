# Aman Compass System Architecture

This document provides a comprehensive overview of the Aman Compass platform architecture, including all layers, components, and their interactions.

## 1. System Overview

Aman Compass is a dual‑layer civic intelligence platform consisting of:

- **Citizen Experience Layer**  A Flutter‑based mobile application that provides AI‑powered guidance, service discovery, and reporting tools to UAE residents.
- **Government Intelligence Dashboard**  A secure web portal that visualizes anonymized civic signals and provides predictive analytics for proactive governance.

The platform is built on a cloud‑native microservices architecture deployed in Azure UAE regions, ensuring data sovereignty and compliance with UAE PDPL.


## 2. High Level Architecture
┌─────────────────────────────────────────────────────────────────┐
│                    Citizen App (Flutter)                         │
│  – Emirate Context Engine   – 5 Intelligence Pillars             │
│  – AI Civic Assistant        – Offline Cache                     │
│  – Phishing Reporting        – Accessibility                     │
└────────────────────────────────┬────────────────────────────────┘
│ HTTPS
┌────────────────────────────────▼────────────────────────────────┐
│                     API Gateway (Kong / Azure APIM)              │
│  – JWT Validation   – Rate Limiting   – Circuit Breakers        │
│  – Request Routing   – Abuse Protection                          │
└────────────────────────────────┬────────────────────────────────┘
│
┌────────────────────────────────▼────────────────────────────────┐
│                      Core Microservices (Node.js)                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐   │
│  │ Auth Service │  │    Entity    │  │  Geo-Intelligence    │   │
│  │ (UAE PASS)   │  │   Registry   │  │      Service         │   │
│  └──────────────┘  └──────────────┘  └──────────────────────┘   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐   │
│  │    Alerts    │  │    Civic     │  │    Predictive        │   │
│  │   Service    │  │ Trend Engine │  │ Analytics Engine     │   │
│  └──────────────┘  └──────────────┘  └──────────────────────┘   │
│  ┌───────────────────────────────────────────────────────────┐   │
│  │              Phishing Intelligence Engine                  │   │
│  └───────────────────────────────────────────────────────────┘   │
└────────────────────────────────┬────────────────────────────────┘
│
┌────────────────────────────────▼────────────────────────────────┐
│                      AI Layer (Python FastAPI)                    │
│  ┌──────────────────┐  ┌──────────────────┐                     │
│  │     LangChain    │  │   Vector DB      │                     │
│  │   Orchestrator   │  │   (Pinecone)     │                     │
│  └──────────────────┘  └──────────────────┘                     │
│  ┌──────────────────┐  ┌──────────────────┐                     │
│  │  Azure OpenAI    │  │  Async Queue     │                     │
│  │    GPT-4         │  │  (Redis/Celery)  │                     │
│  └──────────────────┘  └──────────────────┘                     │
└────────────────────────────────┬────────────────────────────────┘
│
┌────────────────────────────────▼────────────────────────────────┐
│                       Data Layer                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐   │
│  │  PostgreSQL  │  │    Redis     │  │   Analytics Lake     │   │
│  │ (Entities,   │  │   (Cache,    │  │   (Anonymized Data)  │   │
│  │   Users)     │  │   Session)   │  │                      │   │
│  └──────────────┘  └──────────────┘  └──────────────────────┘   │
│  ┌───────────────────────────────────────────────────────────┐   │
│  │           Differential Privacy Engine                      │   │
│  └───────────────────────────────────────────────────────────┘   │
└────────────────────────────────┬────────────────────────────────┘
│
┌────────────────────────────────▼────────────────────────────────┐
│                Government Intelligence Dashboard                  │
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐     │
│  │    Civic       │  │    Service     │  │   Phishing     │     │
│  │ Confusion      │  │   Pressure     │  │  Campaign Map  │     │
│  │   Heatmap      │  │    Index       │  │                │     │
│  └────────────────┘  └────────────────┘  └────────────────┘     │
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐     │
│  │  Predictive    │  │      SME       │  │   Emergency    │     │
│  │   Demand       │  │  Compliance    │  │ Early Signal   │     │
│  │   Forecast     │  │   Risk Index   │  │   Tracker      │     │
│  └────────────────┘  └────────────────┘  └────────────────┘     │
└─────────────────────────────────────────────────────────────────┘
## 3. Component Details

### 3.1 Citizen Experience Layer (Flutter)
- **Emirate Context Engine**: Personalizes content based on selected or detected emirate.
- **5 Intelligence Pillars**: Civic Navigator, SME Companion, Cyber Trainer, Aman Preparedness, Data Explorer.
- **AI Civic Assistant**: RAG‑based Q&A using Azure OpenAI and vector search.
- **Offline Mode**: Caches critical data using Hive for offline access.
- **Phishing Reporting**: Allows users to submit suspicious SMS, URLs, or screenshots.
- **Accessibility**: Full Arabic/English RTL support, quick exit button, screen reader compatibility.

### 3.2 API Gateway (Kong / Azure APIM)
- **JWT Validation**: Verifies UAE PASS tokens.
- **Rate Limiting**: Prevents abuse and ensures fair usage.
- **Circuit Breakers**: Handles downstream service failures gracefully.
- **Request Routing**: Directs traffic to appropriate microservices.

### 3.3 Core Microservices (Node.js)

| Service | Description | Database |
|---------|-------------|----------|
| **Auth Service** | UAE PASS OAuth2 integration, JWT issuance | PostgreSQL |
| **Service Registry** | Central repository of government entities and services | PostgreSQL |
| **Geo-Intelligence** | Location‑based services, nearest facility lookup | Redis (cache) |
| **Alert & Notification** | Push notifications (Firebase), SMS, email | Redis |
| **Civic Trend Engine** | Aggregates anonymized search and interaction signals | Data Lake |
| **Predictive Analytics** | ML forecasting for service demand and confusion metrics | Data Lake |
| **Phishing Intelligence** | AI‑based clustering of reported scams | Data Lake |

### 3.4 AI Layer (Python FastAPI)
- **LangChain Orchestrator**: Manages RAG workflows and tool use.
- **Vector DB (Pinecone)**: Stores embeddings for semantic search.
- **Azure OpenAI GPT‑4**: Powers the civic assistant (UAE region hosted).
- **Async Queue (Redis/Celery)**: Handles high‑volume requests asynchronously.

### 3.5 Data Layer
- **PostgreSQL**: Primary operational database for entities and users.
- **Redis**: Caching and session management.
- **Analytics Lake**: Aggregated, anonymized data for reporting and ML.
- **Differential Privacy Engine**: Ensures no PII is exposed in analytics outputs.

### 3.6 Government Intelligence Dashboard (React/Next.js)
- **Civic Confusion Heatmap**: Visualizes topics with high search volume or confusion.
- **Service Pressure Index**: Tracks demand for services by emirate.
- **Phishing Campaign Map**: Shows emerging scam clusters geographically.
- **Predictive Demand Forecast**: ML‑based predictions of future service load.
- **SME Compliance Risk Index**: Highlights areas where SMEs struggle with regulations.
- **Emergency Early Signal Tracker**: Detects civic signals that may indicate emerging crises.

### 3.7 Security & Compliance
- **WAF / DDoS Protection**: Azure Front Door + WAF.
- **Key Vault**: Azure Key Vault for secrets management.
- **PDPL Compliance**: Data minimization, consent management, anonymization.
- **Audit Logs**: Immutable logs for all system access and changes.

### 3.8 Infrastructure & DevOps
- **Terraform**: Infrastructure as Code for Azure resources.
- **Kubernetes (AKS)**: Container orchestration for microservices.
- **CI/CD**: GitHub Actions for automated testing and deployment.
- **Monitoring**: Azure Monitor, Application Insights, Grafana.
- ## 4. Data Flow

### 4.1 Citizen Query Flow
1. User submits query via AI assistant.
2. Request passes through API Gateway (JWT validation, rate limiting).
3. AI Layer retrieves relevant context from Vector DB and generates response via Azure OpenAI.
4. Response returned to user; query metadata (anonymized) sent to Civic Trend Engine.

### 4.2 Phishing Report Flow
1. User submits suspicious SMS/URL/screenshot.
2. Report sent to Phishing Intelligence Engine.
3. AI clusters report with similar patterns; updates Phishing Campaign Map.
4. If threshold exceeded, alert generated for government dashboard.

### 4.3 Analytics Flow
1. Raw interaction data passes through Differential Privacy Engine.
2. Anonymized data stored in Analytics Lake.
3. Predictive models consume aggregated data to generate forecasts.
4. Dashboard visualizes insights for authorized government users.
## 5. Deployment Architecture

The platform is deployed in Azure UAE regions with the following topology:

- **AKS Cluster**: Hosts all microservices and AI layer.
- **Azure Database for PostgreSQL**: Managed database service.
- **Azure Cache for Redis**: Managed Redis service.
- **Azure Storage Account**: Data Lake storage.
- **Azure Front Door**: Global load balancing, WAF, DDoS protection.
- **Azure Key Vault**: Secrets management.
- **Azure Monitor**: Logging and metrics.

All data resides within UAE borders, ensuring compliance with data sovereignty requirements.

## 6. Integration Points

| Integration | Purpose | Protocol |
|-------------|---------|----------|
| UAE PASS | Citizen authentication | OAuth2 / OpenID Connect |
| Firebase Cloud Messaging | Push notifications | HTTP / FCM |
| Dubai Pulse API | Open data integration | REST |
| Bayanat.ae | Geospatial services | REST |
| NCEMA | Emergency alerts (future) | REST / Webhook |
| NCM | Weather warnings (future) | REST / WebSocket |

## 7. Scalability Considerations

- **Horizontal Scaling**: All microservices are stateless and can scale independently on AKS.
- **Database Scaling**: PostgreSQL read replicas for analytics queries; connection pooling.
- **AI Layer Scaling**: Async queue for high‑volume requests; vector DB can scale horizontally.
- **Caching**: Redis for frequently accessed data; CDN for static assets.

---

## 8. Security Architecture

- **Network Security**: Private VNet, service endpoints, network policies in AKS.
- **Identity & Access**: UAE PASS for citizens; Azure AD for government users.
- **Data Protection**: Encryption at rest (AES‑256) and in transit (TLS 1.3).
- **Audit**: Immutable logs stored in secure storage; access monitored.


## 9. Monitoring & Observability

- **Metrics**: Azure Monitor, Prometheus for custom metrics.
- **Logs**: Centralized logging with Azure Log Analytics.
- **Tracing**: Distributed tracing with Application Insights / OpenTelemetry.
- **Dashboards**: Grafana for operational dashboards; custom dashboard for government intelligence.


## 10. Conclusion

The Aman Compass architecture is designed for **scalability, security, and privacy**. It leverages cloud‑native technologies and AI to deliver actionable intelligence while maintaining strict compliance with UAE regulations. The modular design allows for phased implementation and future expansion.
