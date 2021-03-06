# Google Coud Run For Anthos Demo

## Requirements
- Terraform
- [Setting up the command-line environment](https://cloud.google.com/anthos/run/docs/install/outside-gcp/command-line-tools)

## How to run

### Authenticate with GCP
```
gcloud auth application-default login
```

### Set default project
```
gcloud config set project [YOUR_PROJECT_ID]
```

### Create variables file
```
echo "gcp_project = \""$(gcloud config get-value project)"\"" > terraform/terraform.tfvars
```

### Go to terraform/
```
cd terraform
```

### Initialize Terraform and review resources plan
```
terraform init && terraform plan
```

### Create resources
```
terraform apply -auto-approve
```
