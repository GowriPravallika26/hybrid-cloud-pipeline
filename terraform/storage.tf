resource "google_storage_bucket" "bucket" {
  name     = "${var.gcp_project_id}-function-bucket"
  location = var.gcp_region
}

resource "google_storage_bucket_object" "archive" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.bucket.name
  source = "../function-source.zip"
}