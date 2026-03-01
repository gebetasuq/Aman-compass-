# Aman Compass – Product Roadmap

This document outlines the phased implementation plan for Aman Compass, from initial citizen MVP to full national integration and beyond. The roadmap is designed to be modular, incremental, and responsive to user feedback and emerging government priorities.

---

## 1. Roadmap Overview

| Phase | Timeframe | Focus |
|-------|-----------|-------|
| **Phase I** | 0–6 months | Citizen‑facing MVP: AI assistant, service discovery, phishing reporting, offline mode, basic analytics collection. |
| **Phase II** | 6–12 months | Government dashboard MVP: Civic confusion heatmap, service pressure index, predictive demand forecasts, SME compliance analytics. |
| **Phase III** | 12–18 months | Integration with emergency services, advanced AI layer (LangChain orchestration), predictive analytics, multi‑emirate coverage. |
| **Phase IV** | 18–24 months | Full national rollout, refined AI civic assistant, PDPL audits, enhanced security features (WAF tuning, penetration testing), operational dashboards. |
| **Phase V** | 24+ months | Expansion to cross‑government integration, advanced ML forecasting, citizen feedback loops, multilingual support beyond Arabic/English. |

---

## 2. Key Milestones

| Milestone | Target Date | Status |
|-----------|-------------|--------|
| Citizen App MVP Launch | Month 3 | Planned |
| Government Dashboard Beta | Month 6 | Planned |
| Full AI Orchestration Integration | Month 12 | Planned |
| Emergency Signal Tracker Pilot | Month 15 | Planned |
| National Deployment | Months 18–24 | Planned |

---

## 3. Key Deliverables per Phase

### Phase I – Citizen MVP (0–6 Months)

- Flutter mobile app with offline caching (Hive)
- AI‑powered guidance (RAG‑based Q&A using Azure OpenAI)
- Phishing report submission module (SMS, URL, screenshot)
- Basic analytics collection (anonymized search queries)
- UAE PASS authentication integration (sandbox)
- Emirate selector with persistent storage
- 5‑pillar navigation screens (Civic, SME, Cyber, Aman, Data)
- Arabic/English RTL support with quick exit button

### Phase II – Government Dashboard MVP (6–12 Months)

- Government dashboard (React/Next.js) with secure access
- Service pressure index visualization
- Civic confusion heatmap (aggregated search topics)
- SME compliance tracker (regulatory question trends)
- API integrations for core microservices (entity registry, trend engine)
- Phishing report dashboard (manual review workflow)
- Differential privacy engine for analytics

### Phase III – Predictive & Emergency Integration (12–18 Months)

- Predictive analytics engine deployment (ML forecasting)
- Geo‑intelligence microservice integration
- Asynchronous processing queue for high‑volume AI requests
- Advanced AI model orchestration (LangChain)
- Emergency early signal tracker (anomaly detection)
- Integration with NCEMA / NCM (weather, emergency alerts)
- Multi‑emirate data coverage (all 7 emirates)

### Phase IV – National Rollout (18–24 Months)

- Full security audit and PDPL compliance certification
- Penetration testing and WAF tuning
- Operational dashboards for government agencies
- Cross‑emirate service coverage
- Full multi‑language support (Arabic/English, with framework for more)
- Blue‑green deployment infrastructure for zero‑downtime updates

### Phase V – Future Expansion (24+ Months)

- AI enhancements and knowledge base expansion
- Integration with external civic data sources (Dubai Pulse, Bayanat.ae, TAMM)
- Citizen feedback and behavior analytics
- Advanced ML forecasting with external datasets
- Support for additional languages (Urdu, Hindi, etc.)
- Cross‑government API federation
- Digital twin integration (if adopted nationally)

---

## 4. Risk & Mitigation

| Risk | Mitigation Strategy |
|------|---------------------|
| **Data Privacy Breach** | Differential privacy engine, end‑to‑end encryption (AES‑256, TLS 1.3), strict access control (RBAC), immutable audit logs. |
| **Service Downtime** | AKS horizontal scaling, blue‑green deployments, automated health checks, 24/7 monitoring (Azure Monitor, Grafana). |
| **AI Model Errors** | Human‑in‑the‑loop oversight for critical alerts, continuous retraining with new data, A/B testing of model versions. |
| **Citizen Adoption** | Multilingual support, clear onboarding, accessible UX, regular user testing, in‑app feedback collection. |
| **Regulatory Changes** | Continuous PDPL review, quarterly compliance audits, agile adaptation framework, legal advisory partnership. |
| **Government Buy‑In** | Pilot with one emirate first, demonstrate clear ROI, share dashboard prototypes early, involve stakeholders in roadmap reviews. |
| **Infrastructure Costs** | Auto‑scaling policies, cost governance alerts, reserved instances for baseline load, regular cost reviews. |

---

## 5. Resource Requirements by Phase

| Role | Phase I | Phase II | Phase III | Phase IV | Phase V |
|------|---------|----------|-----------|----------|---------|
| Flutter Developers | 2 | 2 | 2 | 2 | 2 |
| Backend Developers | 2 | 3 | 3 | 4 | 4 |
| AI/ML Engineers | 0 | 1 | 2 | 3 | 4 |
| Data Scientists | 0 | 1 | 2 | 2 | 3 |
| UI/UX Designers | 1 | 1 | 1 | 1 | 1 |
| DevOps Engineers | 1 | 1 | 2 | 2 | 2 |
| Security Specialists | 0.5 | 1 | 1 | 1 | 1 |
| Project Managers | 1 | 1 | 1 | 1 | 1 |
| **Total** | **7.5** | **11** | **14** | **16** | **18** |

---

## 6. Success Metrics

### User Adoption
- **Phase I**: 1,000+ monthly active users
- **Phase II**: 5,000+ monthly active users
- **Phase III**: 20,000+ monthly active users
- **Phase IV**: 50,000+ monthly active users
- **Phase V**: 100,000+ monthly active users

### Government Engagement
- **Phase II**: 5+ agencies reviewing dashboard
- **Phase III**: 10+ agencies with active access
- **Phase IV**: 20+ integrated government systems
- **Phase V**: Cross‑ministry data sharing established

### Technical Performance
- **All Phases**: 99.5% uptime
- **All Phases**: < 500ms API response time (p95)
- **All Phases**: < 24 hour bug fix SLA for critical issues

---

## 7. Quarterly Review Process

The roadmap is reviewed and adjusted quarterly based on:
- User feedback and adoption metrics
- Government partner priorities
- Technological advances (AI, cloud, security)
- Regulatory updates
- Resource availability

Each review produces:
- Updated timeline for next phases
- Prioritized feature backlog
- Risk register update
- Stakeholder communication

---

## 8. Related Documents

- [Architecture Guide](architecture.md)
- [Deployment Guide](deployment.md)
- [PDPL Compliance](pdpl_compliance.md)
- [Budget & Financial Projection](../budget.md)
- [Contributing Guidelines](../CONTRIBUTING.md)

---

## 9. Revision History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | March 2026 | Initial roadmap document | Product Team |

---

*This roadmap is a living document and will evolve as the platform grows and user needs change. Last updated: March 2026.*
