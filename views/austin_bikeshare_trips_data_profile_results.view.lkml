view: austin_bikeshare_trips_data_profile_results {
  sql_table_name: `stellar-cumulus-449523-b8.dataplex_dq_demo.austin_bikeshare_trips_data_profile_results` ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: CONCAT(${TABLE}.data_profile_job_id, '_', ${TABLE}.column_name) ;;
    description: "Unique composite identifier: Job ID + Column Name."
  }

  dimension: data_profile_job_id {
    type: string
    sql: ${TABLE}.data_profile_job_id ;;
    description: "The unique job execution ID for the Dataplex profile scan."
  }

  dimension: column_name {
    type: string
    sql: ${TABLE}.column_name ;;
    description: "The name of the profiled column in the source dataset."
  }

  dimension: column_type {
    type: string
    sql: ${TABLE}.column_type ;;
    description: "Data type of the profiled column (e.g. INTEGER, STRING)."
  }

  dimension: column_mode {
    type: string
    sql: ${TABLE}.column_mode ;;
    description: "Mode of the column (e.g. NULLABLE, REQUIRED)."
  }

  dimension_group: job_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.job_start_time ;;
    description: "Start timestamp of the profile scan job."
  }

  dimension_group: job_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.job_end_time ;;
    description: "End timestamp of the profile scan job."
  }

  dimension: job_rows_scanned {
    type: number
    sql: ${TABLE}.job_rows_scanned ;;
    description: "Total rows scanned during this job execution."
  }

  # --- Core Profile Dimensions ---

  dimension: percent_null {
    type: number
    sql: ${TABLE}.percent_null / 100.0 ;; # Store as decimal ratio (e.g. 0.015 instead of 1.5) for Looker percentage formatting
    value_format_name: percent_2
    description: "Percentage of null values found in this column."
  }

  dimension: percent_unique {
    type: number
    sql: ${TABLE}.percent_unique / 100.0 ;;
    value_format_name: percent_2
    description: "Percentage of unique values found in this column."
  }

  dimension: min_value {
    type: number
    sql: ${TABLE}.min_value ;;
    value_format_name: decimal_2
    description: "Minimum value (numeric columns only)."
  }

  dimension: max_value {
    type: number
    sql: ${TABLE}.max_value ;;
    value_format_name: decimal_2
    description: "Maximum value (numeric columns only)."
  }

  dimension: average_value {
    type: number
    sql: ${TABLE}.average_value ;;
    value_format_name: decimal_2
    description: "Average value (numeric columns only)."
  }

  dimension: standard_deviation {
    type: number
    sql: ${TABLE}.standard_deviation ;;
    value_format_name: decimal_2
    description: "Standard deviation of values (numeric columns only)."
  }

  # --- Quartiles ---

  dimension: quartile_lower {
    type: number
    sql: ${TABLE}.quartile_lower ;;
    value_format_name: decimal_2
  }

  dimension: quartile_median {
    type: number
    sql: ${TABLE}.quartile_median ;;
    value_format_name: decimal_2
  }

  dimension: quartile_upper {
    type: number
    sql: ${TABLE}.quartile_upper ;;
    value_format_name: decimal_2
  }

  # --- String Metrics ---

  dimension: min_string_length {
    type: number
    sql: ${TABLE}.min_string_length ;;
  }

  dimension: max_string_length {
    type: number
    sql: ${TABLE}.max_string_length ;;
  }

  dimension: average_string_length {
    type: number
    sql: ${TABLE}.average_string_length ;;
    value_format_name: decimal_2
  }

  # --- Measures ---

  measure: count {
    type: count
    label: "Total Column Profile Records"
  }

  measure: average_null_percent {
    type: average
    sql: ${percent_null} ;;
    value_format_name: percent_2
    description: "Average null rate across runs."
  }

  measure: max_null_percent {
    type: max
    sql: ${percent_null} ;;
    value_format_name: percent_2
    description: "Maximum null rate observed."
  }

  measure: average_unique_percent {
    type: average
    sql: ${percent_unique} ;;
    value_format_name: percent_2
    description: "Average uniqueness rate across runs."
  }

  measure: total_rows_scanned {
    type: max
    sql: ${job_rows_scanned} ;;
    value_format_name: decimal_0
    description: "The maximum number of rows scanned in any single run."
  }
}
