# Azure .NET DevOps Demo with Terraform, Docker and GitHub Actions

Demo project showing:

- ASP.NET Core API
- Docker containerization
- Terraform-managed Azure infrastructure
- Azure Virtual Machine deployment
- Azure Container Registry with Managed Identity authentication
- GitHub Actions CI/CD pipeline

## Run locally

Run directly:

```bash

dotnet run --project ./src/Web

```

Or using Docker:
```bash

docker build -t <IMAGE_NAME> .
docker run -p 8080:8080 <IMAGE_NAME>

```

## Infrastructure

Azure resources are provisioned using Terraform.

Terraform variables are defined in `variables.tf`.

Most infrastructure values have sensible defaults, while environment-specific values are provided through `terraform.tfvars`.

Before running Terraform, copy `terraform.tfvars.example` file to `terraform.tfvars` and fill in proper key name.

The Terraform deployment creates:

- Resource Group
- Virtual Network
- Subnet
- Network Security Group
- Public IP
- Linux Virtual Machine
- Azure Container Registry
- User Assigned Managed Identity
- AcrPull role assignment

## Terraform commands

Initialize:

```bash

terraform init

```

Preview changes:
```bash

terraform plan

```

Deploy infrastructure:
```bash

terraform apply

```

Destroy:
```bash

terraform destroy

```

## Deployment

Deployment is handled through GitHub Actions.

The pipeline:

1. Authenticates to Azure using OpenID Connect.
2. Builds the Docker image.
3. Pushes the image to Azure Container Registry.
4. Connects to the Azure VM through SSH.
5. Authenticates using the VM Managed Identity.
6. Pulls the latest image using Docker Compose.
7. Restarts the container.

## GitHub Actions configuration

The GitHub Actions workflow requires the following repository variables and secrets.

### Repository Variables

Add these under:

`Settings --> Secrets and variables --> Actions --> Variables`

| Variable | Description | Example |
|---|---|---|
| `AZURE_CLIENT_ID` | Azure Service Principal application/client ID used for OIDC authentication | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `AZURE_TENANT_ID` | Azure tenant ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `AZURE_SUBSCRIPTION_ID` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `ACR_NAME` | Azure Container Registry name | `nameofazurecontainerregistryloginserver` |
| `ACR_LOGIN_SERVER` | Azure Container Registry login server | `nameofazurecontainerregistryloginserver.azurecr.io` |
| `IMAGE_NAME` | Docker image name | `docker_image_name` |
| `IMAGE_TAG` | Docker image tag | `latest` |
| `VM_HOST` | Public IP address or hostname of the deployment VM | `xxx.xxx.xxx.xxx` |

### Repository Secrets

Add these under:

`Settings --> Secrets and variables --> Actions --> Secrets`

| Secret | Description |
|---|---|
| `VM_SSH_PRIVATE_KEY` | Private SSH key used by GitHub Actions to connect to the Azure VM |

### Security notes

- Azure authentication uses OpenID Connect (OIDC), so no Azure client secret is stored in GitHub.
- The VM uses a User Assigned Managed Identity with the `AcrPull` role to authenticate against Azure Container Registry.

## Azure VM configuration

During deployment, GitHub Actions creates the `.env` file and `docker-compose.yml` on the VM.

```env
ACR_LOGIN_SERVER=nameofazurecontainerregistryloginserver.azurecr.io
IMAGE_NAME=docker_image_name
IMAGE_TAG=latest
```