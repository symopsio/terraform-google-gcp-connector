# gcp-connector

The `gcp-connector` module provisions the resources required for the Sym Runtime to access Google Cloud Platform 
resources via [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation)

## Pre-requisites
To apply this module, the [Google Cloud Platform Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs) 
must be configured with credentials that have the permissions to:
  - Enable APIs in the Project where the Workload Identity Pool will be created
  - Create Workload Identity Pools and Providers
  - Create and manage Service Accounts

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
