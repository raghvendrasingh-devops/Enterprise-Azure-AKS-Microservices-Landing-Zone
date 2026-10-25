<div align="center">

  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=10,35,60&height=220&section=header&text=ENTERPRISE%20AZURE%20AKS%20LANDING%20ZONE&fontSize=36&fontAlignY=38&animation=fadeIn&fontColor=ffffff&desc=Private%20Kubernetes%20Cluster%20%7C%20Azure%20CNI%20%7C%20Key%20Vault%20CSI%20%7C%20ACR%20Private%20Link&descSize=16&descAlignY=62&descAlign=50" width="100%" alt="AKS Landing Zone Banner" />

  <p align="center">
    <img src="https://img.shields.io/badge/Kubernetes-AKS_Private_Cluster-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white" />
    <img src="https://img.shields.io/badge/Networking-Azure_CNI_%26_Policies-0078D4?style=for-the-badge&logo=microsoftazure" />
    <img src="https://img.shields.io/badge/Security-Key_Vault_CSI_Driver-00C853?style=for-the-badge&logo=shield" />
    <img src="https://img.shields.io/badge/Registry-ACR_Premium_Private_Link-orange?style=for-the-badge&logo=docker" />
    <img src="https://img.shields.io/badge/IaC-Terraform_Modular-7B42BC?style=for-the-badge&logo=terraform" />
  </p>

</div>

---

## 🏛️ Architecture Overview

This repository delivers an **Enterprise Cloud-Native Kubernetes (AKS) Landing Zone** aligned with the Microsoft Cloud Adoption Framework (CAF) zero-trust baseline.

The cluster operates in **100% Private Mode**, completely eliminating public internet exposure for the Kubernetes API server and worker nodes.

```mermaid
graph TD
    subgraph ManagementVNet["🌐 Hub & Management Network"]
        BASTION["Azure Bastion Host"]
        DEVOPS["Azure DevOps / GitHub Runner"]
    end

    subgraph AKSSpokeVNet["⚡ AKS Spoke VNet (172.16.48.0/20)"]
        subgraph IngressSubnet["Ingress Tier Subnet"]
            AGIC["Application Gateway Ingress Controller (WAF)"]
        end

        subgraph SystemNodes["System Node Pool (Multi-AZ)"]
            SYS["Core System Pods (CoreDNS, Metrics, CSI)"]
        end

        subgraph UserNodes["User Workload Node Pool (Autoscaling)"]
            MICRO["Containerized Microservices Pods"]
        end

        subgraph PrivateLinkSubnet["Private Link Subnet"]
            PE_ACR["Private Endpoint: ACR Premium"]
            PE_KV["Private Endpoint: Azure Key Vault"]
        end
    end

    BASTION -.-> |"Private kubectl Admin"| SYS
    AGIC ==> |"Layer 7 Routing"| MICRO
    MICRO ==> |"AcrPull (Private Link)"| PE_ACR
    MICRO ==> |"Secret Store CSI Driver"| PE_KV
```

---

## ⚡ Key Highlights

| Pillar | Architecture Scope & Hardening |
| :--- | :--- |
| **🔒 Fully Private Cluster** | The API server uses a private IP address (`privatelink.eastus2.azmk8s.io`); zero direct internet access. |
| **🌐 Azure CNI Networking** | Direct native VNet IP allocation per pod with granular **Azure Network Policies** enforcing zero-trust pod isolation. |
| **🔑 Passwordless Secrets** | **Azure Key Vault Secrets Store CSI Driver** dynamically mounts secrets into pod memory without etcd persistence. |
| **🛡️ Hardened Container Security** | Non-root containers, read-only root filesystems, dropped Linux capabilities, and ACR image content trust. |
| **📦 Production Kubernetes Manifests** | Out-of-the-box production YAML templates for Deployments, Services, Ingress, NetworkPolicies, and SecretProviderClasses. |

---

## 📁 Repository Structure

```text
Enterprise-Azure-AKS-Microservices-Landing-Zone/
├── .github/workflows/
│   └── devsecops-ci-cd.yml       # DevSecOps Pipeline: Terraform & K8s Manifest Validation
├── k8s/
│   └── base/                     # Hardened Kubernetes Production Manifests
│       ├── namespace.yaml
│       ├── deployment.yaml       # Non-root, Read-only Root FS, Probes
│       ├── service.yaml          # ClusterIP
│       ├── network-policy.yaml   # Default Deny Ingress
│       └── secret-provider-class.yaml
├── terraform/
│   ├── modules/
│   │   ├── aks_network/          # Spoke VNet, Subnet Sizing, Private DNS
│   │   ├── aks_cluster/          # Private AKS, Multi-AZ Node Pools, CSI
│   │   └── aks_acr/              # ACR Premium with Private Endpoint
│   └── environments/
│       └── prod/
│           ├── main.tf
│           ├── variables.tf
│           ├── terraform.tfvars
│           └── versions.tf
└── README.md
```

---

## 🚀 Quick Start & Deployment

```bash
cd terraform/environments/prod

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Review execution plan
terraform plan

# Apply Landing Zone
terraform apply -auto-approve
```

---

## 👤 Author
**Raghvendra Singh**  
Principal DevSecOps Architect & Enterprise Cloud Strategist  
GitHub: [@raghvendrasingh-devops](https://github.com/raghvendrasingh-devops)  
LinkedIn: [raghvendra-singh-devops](https://linkedin.com/in/raghvendra-singh-devops)
