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

variable "accessible_secrets" {
  description = "A map of google_secret_manager_secret objects to grant the Sym Integration read-only access to."
  type = list(object({
    project   = string
    secret_id = string
    name      = string
  }))
  default = []
}

variable "sym_account_id" {
  description = "The AWS account ID that can impersonate the created Google service account. Defaults to the Sym Production AWS account ID."
  type        = string
  default     = "803477428605"
}

variable "sym_runtime_arn" {
  description = "The ARN of the Sym Runtime Role, which will be impersonating the created Google service account. Defaults to the Sym Production Runtime ARN."
  type        = string
  default     = "arn:aws:sts::803477428605:assumed-role/phoenix-prod-runtime/phoenix-prod-runtime"
}
