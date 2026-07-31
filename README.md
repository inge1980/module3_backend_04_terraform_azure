# Azure Dotnet Terraform Demo

Demo project showing:

- ASP.NET Core API
- Docker containerization
- Terraform Azure infrastructure
- GitHub Actions CI/CD
- Azure Container Registry deployment

## Run locally

```bash
dotnet run --project ./src/Web

## Github / Azure

Azure authentication uses GitHub Actions OIDC.
Required repository variables:
- AZURE_CLIENT_ID
- AZURE_TENANT_ID
- AZURE_SUBSCRIPTION_ID
- ACR_LOGIN_SERVER