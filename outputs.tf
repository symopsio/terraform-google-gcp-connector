output "service_account" {
  value = google_service_account.sym
}

output "workload_identity_pool_provider" {
  value = google_iam_workload_identity_pool_provider.sym_integration_aws_provider
}

output "workload_identity_pool" {
  value = google_iam_workload_identity_pool.sym_integration
}

output "sym_integration" {
  value = sym_integration.google_workload_identity_federation
}
