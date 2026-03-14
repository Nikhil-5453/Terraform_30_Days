# Terraform 30 Days Challenge -> Day-02/Provider.tf

## Understanding Provider.tf

The `Provider.tf` file is crucial in Terraform configurations as it defines the providers needed for your infrastructure. Providers are plugins that Terraform uses to interact with cloud platforms, APIs, or other services. In this file, we specify the required providers and their configurations.

### Key Components:

1. **Terraform Block**:
   - This block declares the requirements for the Terraform configuration.
   - It ensures compatibility and specifies which providers are needed.

2. **Required Providers** (Line 2 starts this block):
   - `required_providers` is a map that lists the providers your configuration depends on.
   - Each provider has a `source` (where to download it from) and a `version` constraint.
   - **Version Constraints**: Terraform uses semantic versioning for constraints.
     - `~> 6.0` for AWS provider means "at least 6.0.0 but less than 7.0.0". This allows patch and minor updates but prevents breaking changes from major version bumps.
     - `~> 3.1` for Random provider means "at least 3.1.0 but less than 4.0.0".
   - Why use constraints? They ensure reproducible builds and prevent unexpected changes when providers update.

3. **Provider Configuration**:
   - After declaring required providers, we configure the AWS provider.
   - `region = var.aws_region`: Uses a variable for the AWS region, making it flexible.
   - `shared_config_files` and `shared_credentials_files`: Point to your AWS CLI config and credentials files, using variables for paths.

### Why This Matters:
- Provider versions can introduce breaking changes, so pinning versions ensures stability.
- Using variables for sensitive paths keeps credentials out of version control.


-----------------------------------------------------------------------------------------

## Overview of the Work

This is **Day 2** of the Terraform 30 Days Challenge. In this day, we learn how to create an AWS EC2 instance with a custom security group that allows inbound traffic on ports 22 (SSH), 80 (HTTP), and 443 (HTTPS). The configuration uses variables for flexibility and best practices.

### What We Build

- **AWS Security Group**: A security group named `new_sg` with rules for SSH, HTTP, and HTTPS access from anywhere (0.0.0.0/0).
- **AWS EC2 Instance**: A t3.micro instance using a specific AMI, attached to the security group, with an 8GB GP3 root volume.

## Prerequisites

Before running this Terraform configuration, ensure you have:

1. **Terraform Installed**: Compatible version (e.g., ~>2.0.0).
2. **AWS Account**: With appropriate permissions to create EC2 instances and security groups.
3. **AWS CLI Configured**: Set up your AWS credentials and config files.
4. **Variables File**: Create `terraform.tfvars` based on `terraform.tfvars.example`.

## File Structure

```
Day-02/
├── main.tf                 # Main Terraform configuration (resources)
├── Provider.tf             # Provider configuration and required providers
├── varibles.tf             # Variable definitions
├── terraform.tfvars        # Your actual variable values (create from example)
├── terraform.tfvars.example # Example variable file
├── .terraform/             # Terraform state directory (auto-generated)
├── terraform.tfstate       # Terraform state file
└── terraform.tfstate.backup # Backup of state file
```

## Configuration Details

### Variables

- `aws_region`: The AWS region where resources will be deployed (e.g., "ap-south-1").
- `config`: Path to your AWS config file (e.g., "~/.aws/config").
- `creds`: Path to your AWS credentials file (e.g., "~/.aws/credentials").

### Resources

1. **aws_security_group**: Creates a security group for the instance.
2. **aws_security_group_rule** (3 rules): Adds ingress rules for ports 22, 80, and 443.
3. **aws_instance**: Launches an EC2 instance with the specified AMI and instance type.

## Usage

1. **Clone or Navigate to the Directory**:
   ```
   cd Terraform_30_Days/Day-02
   ```

2. **Initialize Terraform**:
   ```
   terraform init
   ```

3. **Review the Plan**:
   ```
   terraform plan
   ```

4. **Apply the Configuration**:
   ```
   terraform apply
   ```

5. **Confirm**: Type `yes` when prompted.

6. **Clean Up** (when done):
   ```
   terraform destroy
   ```

## Key Learnings

- How to define and use variables in Terraform.
- Creating security groups and rules separately for better organization.
- Attaching security groups to EC2 instances.
- Using `count` for resource scaling (set to 1 here).
- Best practices for variable files and sensitive data.

## Notes

- The security group allows access from anywhere (0.0.0.0/0) for learning purposes. In production, restrict CIDR blocks to your IP or VPC.
- The AMI ID `ami-0f559c3642608c138` is specific to the ap-south-1 region; update if deploying elsewhere.
- Always review `terraform plan` output before applying to understand what will be created.

## Next Steps

Continue to Day 3 for more advanced Terraform concepts!</content>
<parameter name="filePath">d:\Devops\Terraform_30_Days\README.md