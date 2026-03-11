resource "google_cloudfunctions_function" "function" {
  name        = "hybrid-bridge-function"
  runtime     = "python39"
  entry_point = "hello_pubsub"

  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.topic.id
  }
}