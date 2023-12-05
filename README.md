# gcp-connector

The `gcp-connector` module provisions the resources required for the Sym Runtime to access Google Cloud Platform 
resources via [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation)

## Pre-requisites
To apply this module, the [Google Cloud Platform Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs) 
must be configured with credentials that have the permissions to:
  - Enable APIs in the Project where the Workload Identity Pool will be created
  - Create Workload Identity Pools and Providers
  - Create and manage Service Accounts

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.7.0 |
| <a name="requirement_sym"></a> [sym](#requirement\_sym) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.7.0 |
| <a name="provider_sym"></a> [sym](#provider\_sym) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_iam_workload_identity_pool.sym_integration](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.sym_integration_aws_provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_project_service.admin_sdk_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.iam_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.resource_manager_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.service_account_credentials_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.sts_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.sym](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [sym_integration.google_workload_identity_federation](https://registry.terraform.io/providers/symopsio/sym/latest/docs/resources/integration) | resource |
| [google_organization.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/organization) | data source |
| [google_project.sym_integration](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_google_group_management"></a> [enable\_google\_group\_management](#input\_enable\_google\_group\_management) | A boolean indicating whether to enable the Admin SDK API to allow the Sym Integration to manage Google Group membership. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | An environment qualifier for the resources this module creates, e.g. staging, or prod. | `string` | n/a | yes |
| <a name="input_gcp_org_id"></a> [gcp\_org\_id](#input\_gcp\_org\_id) | The Organization ID of your Google Cloud Organization | `any` | n/a | yes |
| <a name="input_google_workspace_customer_id"></a> [google\_workspace\_customer\_id](#input\_google\_workspace\_customer\_id) | The Google Workspace Customer ID. Required if managing Google Group memberships. | `string` | `null` | no |
| <a name="input_identity_pool_project_id"></a> [identity\_pool\_project\_id](#input\_identity\_pool\_project\_id) | The Project ID of the Google Cloud Project where the Workload Identity Federation resources will be created in. | `string` | n/a | yes |
| <a name="input_sym_account_id"></a> [sym\_account\_id](#input\_sym\_account\_id) | The AWS account ID that can impersonate the created Google service account. Defaults to the Sym Production AWS account ID. | `string` | `"803477428605"` | no |
| <a name="input_sym_runtime_arn"></a> [sym\_runtime\_arn](#input\_sym\_runtime\_arn) | The ARN of the Sym Runtime Role, which will be impersonating the created Google service account. Defaults to the Sym Production Runtime ARN. | `string` | `"arn:aws:iam::803477428605:role/phoenix-prod-runtime"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | n/a |
| <a name="output_sym_integration"></a> [sym\_integration](#output\_sym\_integration) | n/a |
| <a name="output_validate_google_workspace_customer_id"></a> [validate\_google\_workspace\_customer\_id](#output\_validate\_google\_workspace\_customer\_id) | n/a |
| <a name="output_workload_identity_pool"></a> [workload\_identity\_pool](#output\_workload\_identity\_pool) | n/a |
| <a name="output_workload_identity_pool_provider"></a> [workload\_identity\_pool\_provider](#output\_workload\_identity\_pool\_provider) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
