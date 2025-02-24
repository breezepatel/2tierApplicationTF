# 2-Tier Application Deployment on AWS using Terraform ✨

Welcome to the 2-Tier Application Deployment repository! This project is designed to help you learn and deploy a 2-tier application on AWS Cloud using Terraform. The architecture includes a frontend web server and a backend database, along with other AWS services to ensure scalability, security, and high availability.

## 🏠 Architecture

The architecture of the 2-tier application consists of the following components:

### Frontend Tier:
- Hosted on Amazon EC2 instances in a public subnet.
- Configured with an Auto Scaling Group (ASG) for scalability.
- Fronted by an Application Load Balancer (ALB) to distribute traffic.
- Uses Amazon CloudFront as a Content Delivery Network (CDN) for improved performance.

### Backend Tier:
- Hosted on Amazon RDS (MySQL) in a private subnet for secure data storage.

### Networking:
- Amazon VPC with public and private subnets for network isolation.
- Internet Gateway for internet access to the public subnet.
- NAT Gateway for private subnet resources to access the internet securely.

### Additional Services:
- Amazon S3 for storing Terraform state files.
- Amazon DynamoDB for state locking.
- Amazon Route 53 for DNS management.
- Amazon CloudWatch for monitoring and alarms.

## 🖥️ Installation of Terraform

Before proceeding, ensure that Terraform is installed on your system. Follow the official Terraform installation guide to set it up.

## 👉 Let's Install Dependencies and Deploy the Application

### Clone the Repository:
```bash
git clone https://github.com/breezepatel/2tierApplicationTF
cd root
```

### Initialize Terraform:
Run the following command to initialize Terraform and download the required providers:
```bash
terraform init
```

### Generate SSH Key Pair:
Navigate to the `modules/key/` directory and generate an SSH key pair for accessing the EC2 instances:
```bash
cd ../modules/key/
ssh-keygen
```
When prompted, name the key `client_key` (or any name you prefer).

This will create two files: `client_key` (private key) and `client_key.pub` (public key).

### Configure the Backend:
Edit the `backend.tf` file to configure the S3 backend for storing the Terraform state file:
```hcl
terraform {
  backend "s3" {
    bucket         = "tfstate-breeze-2tier-application" # Replace with your bucket name
    key            = "backend/terraform.tfstate" # Path to store the state file
    region         = "ca-central-1" # Replace with your region
    dynamodb_table = "remote-backend" # Replace with your DynamoDB table name
  }
}
```

### Set Up Variables:
Create a `terraform.tfvars` file to define the variables for your infrastructure:
```bash
vim terraform.tfvars
```
Add the following contents:
```hcl
REGION                  = "" # AWS region
PROJECT_NAME            = "" # Project name
VPC_CIDR                = "" # VPC CIDR block
PUB_SUB_1_A_CIDR        = "" # Public Subnet 1 CIDR
PUB_SUB_2_B_CIDR        = "" # Public Subnet 2 CIDR
PRI_SUB_3_A_CIDR        = "" # Private Subnet 1 CIDR
PRI_SUB_4_B_CIDR        = "" # Private Subnet 2 CIDR
DB_USERNAME             = "" # Database username
DB_PASSWORD             = "" # Database password
CERTIFICATE_DOMAIN_NAME = "" # Domain name for SSL certificate
ADDITIONAL_DOMAIN_NAME  = "" # Additional domain name
```

## ✈️ Deploy the Application

### Review the Execution Plan:
Run the following command to see the execution plan:
```bash
cd root
terraform plan
```

### Deploy the Infrastructure:
Apply the configuration to deploy the application:
```bash
terraform apply
```
Type `yes` when prompted to confirm the deployment.

### Access the Application:
Once the deployment is complete, Terraform will output the ALB DNS name and CloudFront distribution URL.
Use these URLs to access your application.

## 🏠 Clean Up

To avoid unnecessary charges, destroy the infrastructure after testing:
```bash
terraform destroy
```
Type `yes` when prompted to confirm the destruction.

## ✨ Thank You!

Thank you for using this repository to learn and deploy a 2-tier application on AWS using Terraform. If you have any questions or feedback, feel free to open an issue or reach out.

Happy Learning! 😊

## 📂 Repository Structure
```
2-tier-app-terraform/
├── modules/
│   ├── key/                # SSH key pair generation
│   ├── vpc/                # VPC and subnets
│   ├── ec2/                # EC2 instances and ASG
│   ├── rds/                # RDS database
│   ├── alb/                # Application Load Balancer
│   ├── cloudfront/         # CloudFront CDN
│   ├── route53/            # Route 53 DNS
│   ├── nat/                # NAT Gateway
│   └── security-group/     # Security Groups
│
├── root/
│   ├── main.tf             # Main Terraform configuration
│   ├── variables.tf        # Variable definitions
│   ├── terraform.tfvars    # Variable values
│   ├── backend.tf          # Terraform backend configuration
│   ├── provider.tf         # Terraform provider configuration
│   ├── .terraform/         # Terraform initialization directory
│   ├── .terraform.lock.hcl # Terraform dependency lock file
|
├── .gitignore          # Git ignore file
└── README.md           # Project documentation
