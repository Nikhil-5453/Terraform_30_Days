
```markdown
# AWS VPC + S3 Infrastructure with Terraform

## 📌 Overview
This project provisions a custom **AWS VPC** and an **S3 bucket** using Terraform.  
It demonstrates how to build a production-ready network setup with public/private subnets, Internet Gateway, NAT Gateway, route tables, and security groups.  
Additionally, it shows how to create an **implicit dependency** between the VPC and the S3 bucket (via tag references), ensuring Terraform builds resources in the correct order.

---

## 🏗️ Infrastructure Components
- **VPC**
  - CIDR: `172.16.0.0/16`
  - DNS support enabled
- **Subnets**
  - 3 Public subnets (`/22`) across AZs: `ap-south-1a`, `ap-south-1b`, `ap-south-1c`
  - 1 Private subnet (`/24`) for RDS
- **Internet Gateway**
  - Provides internet access for public subnets
- **NAT Gateway**
  - Allows private subnet instances (e.g., RDS) to access the internet for patching/updates
- **Route Tables**
  - Public route table → IGW
  - Private route table → NAT Gateway
- **Security Group**
  - Ingress: `22`, `80`, `443`
  - Egress: `80`, `443`
- **S3 Bucket**
  - Globally unique name with random suffix
  - Versioning enabled
  - Tagged with VPC ID → creates implicit dependency

---

## ⚙️ Variables
Defined in `variables.tf` and overridden in `terraform.tfvars`:

- `Cidrs` → VPC CIDR block
- `Availability_zones` → List of AZs
- `public_subnet_cidrs` → CIDRs for public subnets
- `private_subnet_cidrs` → CIDRs for private subnets

Example `terraform.tfvars`:
```hcl
Cidrs = "172.16.0.0/16"
Availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnet_cidrs = ["172.16.0.0/22", "172.16.4.0/22", "172.16.8.0/22"]
private_subnet_cidrs = ["172.16.30.0/24"]
```

---

## ▶️ Usage

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Validate configuration**
   ```bash
   terraform fmt
   terraform validate
   ```

3. **Preview changes**
   ```bash
   terraform plan
   ```

4. **Apply configuration**
   ```bash
   terraform apply
   ```

---

## 📤 Outputs
After apply, Terraform will print:
- `vpc_id` → VPC ID
- `public_subnet_ids` → IDs of public subnets
- `private_subnet_ids` → IDs of private subnets
- `internet_gateway_id` → IGW ID
- `nat_gateway_id` → NAT Gateway ID
- `public_route_table_id` → Public route table ID
- `private_route_table_id` → Private route table ID
- `security_group_id` → SG ID
- `s3_bucket_name` → S3 bucket name

---

## 🔒 Notes
- CIDRs must align correctly (`/22` boundaries at multiples of 4).
- Always use RFC1918 private ranges (`10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to avoid IP conflicts.
- Implicit dependency is achieved by referencing `aws_vpc.new_vpc.id` in the S3 bucket tags.

---
