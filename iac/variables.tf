variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Region to deploy resources"
  type        = string
  default     = "asia-southeast2"
}

variable "db_name" {
  description = "Cloud SQL database name"
  type        = string
  default     = "appdb"
}

variable "db_user" {
  description = "Cloud SQL username"
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "Cloud SQL user password"
  type        = string
}
