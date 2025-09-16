output "cloud_run_url" {
  value       = google_cloud_run_service.app.status[0].url
  description = "Public URL of Cloud Run service"
}

output "cloudsql_connection_name" {
  value       = google_sql_database_instance.postgres.connection_name
  description = "Cloud SQL connection string for Cloud Run"
}
