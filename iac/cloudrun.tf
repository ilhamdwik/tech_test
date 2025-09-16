resource "google_artifact_registry_repository" "repo" {
  provider      = google
  location      = var.region
  repository_id = "app-repo"
  format        = "DOCKER"
}

resource "google_vpc_access_connector" "serverless_connector" {
  name          = "cloudrun-vpc-connector"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.8.0.0/28" # khusus untuk connector
}

resource "google_cloud_run_service" "app" {
  name     = "simple-app"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/simple-app:latest"
        env {
          name  = "DB_HOST"
          value = "/cloudsql/${google_sql_database_instance.postgres.connection_name}"
        }
        env {
          name  = "DB_NAME"
          value = var.db_name
        }
        env {
          name  = "DB_USER"
          value = var.db_user
        }
        env {
          name  = "DB_PASS"
          value = var.db_password
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  vpc_access {
    connector = google_vpc_access_connector.serverless_connector.id
    egress    = "ALL_TRAFFIC"
  }
}

resource "google_compute_firewall" "allow_vpc_connector_to_db" {
  name    = "allow-vpc-connector-to-db"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["5432"] # PostgreSQL port
  }

  # IP range dari VPC Connector
  source_ranges = ["10.8.0.0/28"]

  # (opsional) target db instance pakai network tags
  target_tags = ["db-instance"]
}

resource "google_cloud_run_service_iam_member" "all_users" {
  service  = google_cloud_run_service.app.name
  location = google_cloud_run_service.app.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}