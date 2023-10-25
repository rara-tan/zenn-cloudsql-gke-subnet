resource "google_sql_database_instance" "sql" {
  project          = var.project_id
  name             = "sql"
  region           = "asia-northeast1"
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.main_network.id
    }
  }
}

resource "google_sql_user" "users" {
  project = var.project_id

  name     = "test-user"
  instance = google_sql_database_instance.sql.name
  password = "password_1234"
}

resource "google_sql_database" "database" {
  project = var.project_id

  name     = "database"
  instance = google_sql_database_instance.sql.name
}
