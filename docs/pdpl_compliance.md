Aman Compass – PDPL Compliance Framework

This document outlines how Aman Compass complies with the UAE Personal Data Protection Law (PDPL) and other relevant data protection regulations.

---

## 1. Overview

The UAE PDPL (Federal Decree‑Law No. 45 of 2021) establishes the legal framework for processing personal data in the UAE. Aman Compass is designed with privacy by design principles, ensuring full compliance while delivering valuable civic intelligence.

---

## 2. Data Protection Principles

| PDPL Principle | Implementation in Aman Compass |
|----------------|--------------------------------|
| **Lawfulness, Fairness, Transparency** | Clear consent prompts at onboarding; privacy policy available in app. |
| **Purpose Limitation** | Data collected only for specified, explicit purposes (service improvement, civic intelligence). |
| **Data Minimization** | Only essential signals collected; no PII in analytics. |
| **Accuracy** | Users can correct their data via in‑app portal. |
| **Storage Limitation** | Raw data deleted after 1 year; anonymized data retained indefinitely. |
| **Integrity & Confidentiality** | End‑to‑end encryption, access controls, audit logs. |
| **Accountability** | Full documentation of processing activities; DPO contact available. |

---

## 3. Data Inventory

### 3.1 Personal Data Collected
| Data Type | Purpose | Retention |
|-----------|---------|-----------|
| UAE PASS UUID | Authentication | Until account deletion |
| Email address | Account recovery, notifications | Until account deletion |
| Device tokens | Push notifications | Until logout or app uninstall |
| Emirate selection | Content personalization | Until changed (stored locally) |
| Favorites list | User preference | Until changed (stored locally) |

### 3.2 Anonymized Data (Not Personal Data)
| Data Type | Purpose | Retention |
|-----------|---------|-----------|
| Search queries (aggregated) | Civic trend analysis | Indefinite |
| Service category interactions | Service pressure index | Indefinite |
| Phishing report metadata | Threat intelligence | Indefinite |
| Geographic patterns (emirate level) | Regional insights | Indefinite |

---

## 4. Consent Management

### 4.1 Consent Collection
- **Onboarding**: Users presented with clear consent options:
  - [ ] I agree to the collection of anonymized usage data to improve services.
  - [ ] I agree to receive push notifications (optional).
  - [ ] I understand that phishing reports will be used for threat intelligence.
- **Granular Controls**: Users can change preferences at any time in Settings.

### 4.2 Consent Records
- Consent choices stored securely in PostgreSQL.
- Timestamp and version of consent recorded.
- Audit trail maintained for regulator review.

---

## 5. Data Anonymization

### 5.1 Differential Privacy Engine
All raw data passes through a differential privacy engine before reaching the analytics lake:

```python
# Pseudocode example
def anonymize_query(user_id, query_text, emirate, timestamp):
    # Remove PII
    query_text = strip_pii(query_text)
    
    # Add statistical noise
    epsilon = 0.1  # privacy budget
    noisy_count = add_laplace_noise(1, epsilon)
    
    # Store only aggregated, anonymized data
    return {
        'emirate': emirate,
        'date': date_only(timestamp),
        'category': classify_query(query_text),
        'noisy_count': noisy_count
    }
```

5.2 Anonymization Techniques

· Aggregation: Data only available at emirate or service category level.
· K‑anonymity: Ensures each combination of attributes appears at least k times.
· Data suppression: Rare combinations excluded from analytics.
· Noise addition: Differential privacy guarantees.

---

6. Data Subject Rights

6.1 Rights and Implementation

Right Implementation
Right to Access Users can request their data via in‑app portal; request processed within 7 days.
Right to Rectification Users can edit profile information directly in app.
Right to Erasure Account deletion option available; data removed within 30 days.
Right to Restriction Users can opt out of analytics at any time.
Right to Data Portability JSON export of user data available on request.
Right to Object Analytics opt‑out available; phishing reporting can be disabled.

6.2 Request Handling Process

1. User submits request via in‑app form.
2. System verifies identity (UAE PASS re‑authentication).
3. Request logged in compliance system.
4. Automated or manual processing based on request type.
5. Response provided within legal timeframe (7 days).
6. Audit trail updated.

---

7. Security Measures

7.1 Technical Controls

Control Implementation
Encryption at Rest AES‑256 for databases, storage accounts.
Encryption in Transit TLS 1.3 for all external communication.
Access Control RBAC with least privilege principle.
Authentication UAE PASS for citizens; Azure AD for government users.
Secrets Management Azure Key Vault with rotation policies.
Audit Logging Immutable logs stored in secure storage.
Network Security Private VNet, service endpoints, WAF.

7.2 Organizational Controls

· Data Protection Officer appointed.
· Regular staff training on data protection.
· Third‑party processor agreements with PDPL clauses.
· Incident response plan documented and tested.

---

8. Data Processing Agreements

All third‑party processors (Azure, Firebase, Pinecone, OpenAI) are bound by data processing agreements that include:

· PDPL compliance obligations
· Data processing scope limitations
· Confidentiality requirements
· Audit rights
· Breach notification obligations
· Sub‑processor restrictions

---

9. Breach Notification

9.1 Incident Response Process

1. Detection: Automated monitoring alerts security team.
2. Assessment: Determine scope, affected individuals, risk level.
3. Containment: Isolate affected systems, revoke compromised credentials.
4. Notification:
   · Notify affected individuals within 72 hours (if high risk).
   · Notify UAE data protection authority.
5. Remediation: Address root cause, improve controls.
6. Documentation: Full incident report for regulator review.

9.2 Contact Information

For data protection inquiries or breach reports:

· DPO Email: dpo@amancompass.ae
· Phone: +971 XX XXX XXXX
· Incident Response Team: security@amancompass.ae

---

10. Data Protection Impact Assessment (DPIA)

A full DPIA has been conducted for Aman Compass, addressing:

· Systematic description of processing
· Necessity and proportionality assessment
· Risks to data subjects
· Mitigation measures
· Consultation with stakeholders

The DPIA is available for regulator review upon request.

---

11. International Data Transfers

All personal data is stored and processed within UAE borders. No international transfers occur.

Anonymized analytics data may be processed in Azure UAE regions only.

---

12. Compliance Checklist

Requirement Status Evidence
Consent mechanism implemented ✅ In‑app consent screens
Privacy policy published ✅ Available in app and website
Data inventory maintained ✅ Section 3 of this document
DPIA completed ✅ Internal document
Data processing agreements signed ✅ On file
Breach notification procedure documented ✅ Section 9
DPO appointed ✅ dpo@amancompass.ae
Staff trained ✅ Training records
Security controls implemented ✅ Section 7

---

13. Contact Information

Data Protection Officer
Email: dpo@amancompass.ae

Legal & Compliance Team
Email: legal@amancompass.ae

For Data Subject Requests
Portal: https://amancompass.ae/privacy/requests
Email: privacy@amancompass.ae

---

14. Review History

Version Date Changes Author
1.0 March 2026 Initial compliance framework Compliance Team

---

15. Related Documents

· Privacy Policy (localized)
· Terms of Service
· Data Processing Agreements
· Security Policies
