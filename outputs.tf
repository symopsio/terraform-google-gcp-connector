output "service_account" {
  value       = google_service_account.sym
  description = "The Google Cloud Platform service account created by this module. See: [google_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account)"
}

output "workload_identity_pool_provider" {
  value       = google_iam_workload_identity_pool_provider.sym_integration_aws_provider
  description = "The Workload Identity Pool Provider created by this module. The identity pool allows access only to the Sym AWS Runtime Role. See: [iam_workload_identity_pool_provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider)"
}

output "workload_identity_pool" {
  value       = google_iam_workload_identity_pool.sym_integration
  description = "The Workload Identity Pool created by this module. See: [iam_workload_identity_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool)"
}

output "sym_integration" {
  value       = sym_integration.google_workload_identity_federation
  description = "The `google` Sym Integration created by this module. This Integration may be used to enable Google SDK methods in a Flow's implementation, or as part of a Google Access Strategy. See our [main documentation](https://docs.symops.com/docs/google) for more information"
}
