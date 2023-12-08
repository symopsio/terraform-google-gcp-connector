variable "environment" {
  description = "An environment qualifier for the resources this module creates, e.g. staging, or prod."
  type        = string
}

variable "gcp_org_id" {
  description = "The Organization ID of your Google Cloud Organization"
}

variable "identity_pool_project_id" {
  description = "The Project ID of the Google Cloud Project where the Workload Identity Federation resources will be created in."
  type        = string
}

variable "enable_google_group_management" {
  description = "A boolean indicating whether to enable the Admin SDK API to allow the Sym Integration to manage Google Group membership."
  type        = bool
  default     = false
}

variable "google_workspace_customer_id" {
  description = "The Google Workspace Customer ID. Required if managing Google Group memberships."
  type        = string
  default     = null
}

output "validate_google_workspace_customer_id" {
  # A workaround to validate that `google_workspace_customer_id` is not empty, if managing Google Groups.
  # See: https://github.com/hashicorp/terraform/issues/25609#issuecomment-1472119672

  value = null
  precondition {
    condition     = (var.enable_google_group_management && var.google_workspace_customer_id != null && var.google_workspace_customer_id != "")
    error_message = "If managing Google Groups, then google_workspace_customer_id is required."
  }

  description = "A null output, used as a workaround to validate that `google_workspace_customer_id` is non-empty if `enable_google_group_management` is true."
}

variable "sym_account_id" {
  description = "The AWS account ID that can impersonate the created Google service account. Defaults to the Sym Production AWS account ID."
  type        = string
  default     = "803477428605"
}

variable "sym_runtime_arn" {
  description = "The ARN of the Sym Runtime Role, which will be impersonating the created Google service account. Defaults to the Sym Production Runtime ARN."
  type        = string
  default     = "arn:aws:iam::803477428605:role/phoenix-prod-runtime"
}
