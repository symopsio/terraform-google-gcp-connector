data "google_project" "sym_integration" {
  project_id = var.identity_pool_project_id
}

data "google_organization" "this" {
  organization = var.gcp_org_id
}

######## Google Workload Identity Federation Resources

# Enable the IAM, Resource Manager, Service Account Credentials, and Security Token Service APIs.
# See: https://cloud.google.com/iam/docs/workload-identity-federation-with-other-clouds#configure
# Note: For all the following, we are setting `disable_on_destroy` and `disable_dependent_services` to False
#  to ensure that destroying this module does not accidentally affect other services that rely on these APIs /
#  accidentally disable any APIs that were already enabled before this module was applied.
resource "google_project_service" "iam_api" {
  project = data.google_project.sym_integration.project_id
  service = "iam.googleapis.com"

  disable_on_destroy         = false
  disable_dependent_services = false
}

resource "google_project_service" "resource_manager_api" {
  project = data.google_project.sym_integration.project_id
  service = "cloudresourcemanager.googleapis.com"

  disable_on_destroy         = false
  disable_dependent_services = false
}

resource "google_project_service" "service_account_credentials_api" {
  project = data.google_project.sym_integration.project_id
  service = "iamcredentials.googleapis.com"

  disable_on_destroy         = false
  disable_dependent_services = false
}

resource "google_project_service" "sts_api" {
  project = data.google_project.sym_integration.project_id
  service = "sts.googleapis.com"

  disable_on_destroy         = false
  disable_dependent_services = false
}

# Create a workload identity pool and provider.
# See: https://cloud.google.com/iam/docs/workload-identity-federation-with-other-clouds#create_the_workload_identity_pool_and_provider
resource "google_iam_workload_identity_pool" "sym_integration" {
  depends_on = [google_project_service.iam_api]

  project = data.google_project.sym_integration.project_id

  workload_identity_pool_id = "sym-${var.environment}"
  display_name              = "Sym (${var.environment})"
  description               = "Identity pool for the Sym Integration"
}

resource "google_iam_workload_identity_pool_provider" "sym_integration_aws_provider" {
  depends_on = [google_project_service.iam_api]

  project = data.google_project.sym_integration.project_id

  workload_identity_pool_id          = google_iam_workload_identity_pool.sym_integration.workload_identity_pool_id
  workload_identity_pool_provider_id = "sym-provider-${var.environment}"

  display_name = "Sym (${var.environment})"
  description  = "AWS identity pool provider for the Sym Integration"

  # Only the Sym Runtime Role may use this identity pool provider
  attribute_condition = "assertion.arn==\"${var.sym_runtime_arn}\""

  attribute_mapping = {
    "google.subject"        = "assertion.arn"
    "attribute.aws_account" = "assertion.account"
  }

  aws {
    # Sym AWS Account ID
    account_id = var.sym_account_id
  }
}

# Create a Service Account for the Sym integration
# See: https://cloud.google.com/iam/docs/workload-identity-federation-with-other-clouds#create_a_service_account_for_the_external_workload
resource "google_service_account" "sym" {
  project = data.google_project.sym_integration.project_id

  account_id   = "sym-integration-${var.environment}"
  display_name = "Sym Integration Service Account"
}

# Allow the Sym Runtime to impersonate the service account
# https://cloud.google.com/iam/docs/workload-identity-federation-with-other-clouds#allow_the_external_workload_to_impersonate_the_service_account
resource "google_service_account_iam_member" "this" {
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.sym.id
  member             = "principal://iam.googleapis.com/projects/${data.google_project.sym_integration.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.sym_integration.workload_identity_pool_id}/subject/${var.sym_runtime_arn}"
}

######## Google Workspace Group Management Resources
locals {
  google_groups_resources_count = var.enable_google_group_management ? 1 : 0
}

# Note: This module does not create the custom role with group management permissions, as that
# must be done manually in the Google Workspace Admin Console.
resource "google_project_service" "admin_sdk_api" {
  count = local.google_groups_resources_count

  # Enable the Admin SDK API for the Workload Identity Pool Google Cloud project
  # This API is required for adding and removing users from Google Workspace Groups.
  project = data.google_project.sym_integration.project_id
  service = "admin.googleapis.com"

  disable_on_destroy         = false
  disable_dependent_services = false
}

######## Sym Resources

# Create a sym_integration for the created Google Workload Identity Federation resources.
resource "sym_integration" "google_workload_identity_federation" {
  external_id = data.google_organization.this.domain
  name        = "google-${var.environment}"
  type   = "google"

  settings = {
    type                              = "external_account"
    audience                          = "//iam.googleapis.com/projects/${data.google_project.sym_integration.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.sym_integration.workload_identity_pool_id}/providers/${google_iam_workload_identity_pool_provider.sym_integration_aws_provider.workload_identity_pool_provider_id}",
    subject_token_type                = "urn:ietf:params:aws:token-type:aws4_request"
    service_account_impersonation_url = "https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/${google_service_account.sym.email}:generateAccessToken"
    token_url                         = "https://sts.googleapis.com/v1/token"

    credential_source = jsonencode({
      environment_id                 = "aws1"
      region_url                     = "http://169.254.169.254/latest/meta-data/placement/availability-zone"
      url                            = "http://169.254.169.254/latest/meta-data/iam/security-credentials"
      regional_cred_verification_url = "https://sts.{region}.amazonaws.com?Action=GetCallerIdentity&Version=2011-06-15"
    })

    customer_id = var.google_workspace_customer_id
  }
}
