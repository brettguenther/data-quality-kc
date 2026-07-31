connection: "default_bigquery_connection"

# Include all views in the views directory
include: "/views/**/*.view"

# Include all dashboard files (if any)
include: "/**/*.dashboard"

explore: austin_bikeshare_trips_dq_results {
  label: "Austin Bikeshare Data Quality Results"
  description: "Explore Dataplex data quality scan results for Austin Bikeshare trips."
}

explore: austin_bikeshare_trips {
  label: "Austin Bikeshare Trips Analytics"
  description: "Explore raw trip metrics and user behavior on Austin Bikeshare."
}
