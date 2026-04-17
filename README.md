# 🚀 AWS 2-Tier Infrastructure using Terraform

## 📌 Overview

This project builds a scalable AWS infrastructure using **Terraform** with a clear separation of **modules** and **environments**.

The architecture follows a basic **2-tier design**:

* Public layer (Web)
* Private layer (App-ready foundation)

It is designed to be reusable, modular, and production-inspired.

---

## 🧱 Architecture

```text
VPC
├── Public Subnet
│   ├── Internet Gateway (IGW)
│   ├── Route Table (Internet Access)
│   └── EC2 (Nginx Web Server)
│
└── Private Subnet
    ├── NAT Gateway
    └── Route Table (Outbound Internet via NAT)
```

---

## 📂 Project Structure

```text
aws-2tier-terraform/
│
├── modules/
│   ├── vpc/              # VPC creation module
│   ├── subnet/           # Reusable subnet module (AZ-aware)
│   ├── network-module/   # IGW, NAT, Route Tables, Associations
│   ├── compute/          # EC2 instance module
│   └── security/         # Security Groups module
│
└── environments/
    └── dev/
        ├── main.tf       # Module orchestration
        ├── variables.tf
        └── terraform.tfvars
```

---

## 🔁 Modules Overview

### 1. VPC Module

* Creates the base VPC
* Outputs `vpc_id`

---

### 2. Subnet Module

Reusable subnet component:

* Supports different CIDRs
* Supports Availability Zones (AZs)
* Can be used for both public and private subnets

---

### 3. Network Module

Handles all networking components:

* Internet Gateway (IGW)
* NAT Gateway
* Public & Private Route Tables
* Route Table Associations

---

### 4. Compute Module

* Creates EC2 instances
* Uses latest Amazon Linux 2023 AMI
* Installs and configures Nginx using `user_data`

---

### 5. Security Module

* Creates Security Groups
* Allows:

  * SSH (22)
  * HTTP (80)

---

## 🌍 Environments

### 🔹 dev

The `dev` environment is used for development and testing purposes.

It deploys:

* VPC
* Public & Private Subnets
* Full networking layer (IGW + NAT + Routes)
* EC2 Web Server (Nginx)

---

## ⚙️ How to Use

### 1. Navigate to environment

```bash
cd environments/dev
```

---

### 2. Initialize Terraform

```bash
terraform init
```

---

### 3. Preview changes

```bash
terraform plan
```

---

### 4. Deploy infrastructure

```bash
terraform apply
```

---

## 🌐 Access the Application

After deployment:

1. Get the EC2 public IP from output or AWS console
2. Open in browser:

```text
http://<EC2-PUBLIC-IP>
```

You should see:

```text
Hello from Terraform EC2 🚀
```

---

## 🧠 Key Concepts Covered

* Terraform Modules (Reusable Infrastructure Design)
* Infrastructure as Code (IaC)
* AWS Networking (VPC, Subnets, IGW, NAT)
* EC2 Provisioning
* User Data Automation (Nginx setup)
* Security Groups
* Environment Separation (dev)

---

## 🚀 Future Improvements

* Add Application Load Balancer (ALB)
* Implement Auto Scaling Groups (ASG)
* Add Remote Backend (S3 + DynamoDB)
* Multi-environment support (dev/staging/prod)
* Multi-AZ high availability architecture

---

## 👨‍💻 Author

Built as part of a DevOps & Cloud Infrastructure learning journey 🚀
