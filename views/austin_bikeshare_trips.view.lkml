view: austin_bikeshare_trips {
  sql_table_name: `stellar-cumulus-449523-b8.dataplex_dq_demo.austin_bikeshare_trips_view` ;;

  dimension: trip_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.trip_id ;;
    description: "Unique trip identifier."
  }

  dimension: subscriber_type {
    type: string
    sql: ${TABLE}.subscriber_type ;;
    description: "The type of membership (e.g., Subscriber, Walk Up)."
  }

  dimension: bike_id {
    type: string
    sql: ${TABLE}.bike_id ;;
    description: "ID of the bike used on the trip."
  }

  dimension: bike_type {
    type: string
    sql: ${TABLE}.bike_type ;;
    description: "The category of bike (e.g., classic, electric)."
  }

  dimension_group: start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.start_time ;;
    description: "Start timestamp of the trip."
  }

  dimension: start_station_name {
    type: string
    sql: ${TABLE}.start_station_name ;;
    description: "Name of the starting bikeshare station."
  }

  dimension: end_station_name {
    type: string
    sql: ${TABLE}.end_station_name ;;
    description: "Name of the ending bikeshare station."
  }

  dimension: duration_minutes {
    type: number
    sql: ${TABLE}.duration_minutes ;;
    description: "Trip duration in minutes."
  }

  # --- Data Quality Measures ---

  measure: count {
    type: count
    label: "Total Rows"
    description: "Total number of row records in the raw table."
    drill_fields: [trip_id, start_station_name, end_station_name, duration_minutes]
  }

  # Null / Missing Value Metrics
  measure: null_subscriber_type_count {
    type: sum
    sql: CASE WHEN ${TABLE}.subscriber_type IS NULL THEN 1 ELSE 0 END ;;
    description: "Number of rows with missing (NULL) subscriber type."
  }

  measure: null_subscriber_type_ratio {
    type: number
    sql: 1.0 * ${null_subscriber_type_count} / NULLIF(${count}, 0) ;;
    value_format_name: percent_2
    description: "Ratio of rows with missing subscriber type to total rows."
  }

  measure: null_start_station_name_count {
    type: sum
    sql: CASE WHEN ${TABLE}.start_station_name IS NULL THEN 1 ELSE 0 END ;;
    description: "Number of rows with missing starting station name."
  }

  measure: null_start_station_name_ratio {
    type: number
    sql: 1.0 * ${null_start_station_name_count} / NULLIF(${count}, 0) ;;
    value_format_name: percent_2
    description: "Ratio of rows with missing starting station name."
  }

  measure: null_end_station_name_count {
    type: sum
    sql: CASE WHEN ${TABLE}.end_station_name IS NULL THEN 1 ELSE 0 END ;;
    description: "Number of rows with missing ending station name."
  }

  measure: null_end_station_name_ratio {
    type: number
    sql: 1.0 * ${null_end_station_name_count} / NULLIF(${count}, 0) ;;
    value_format_name: percent_2
    description: "Ratio of rows with missing ending station name."
  }

  # Duration / Range Outliers
  measure: invalid_duration_count {
    type: sum
    sql: CASE WHEN ${TABLE}.duration_minutes IS NULL OR ${TABLE}.duration_minutes <= 0 THEN 1 ELSE 0 END ;;
    description: "Number of rows with duration <= 0 minutes or null."
  }

  measure: invalid_duration_ratio {
    type: number
    sql: 1.0 * ${invalid_duration_count} / NULLIF(${count}, 0) ;;
    value_format_name: percent_2
    description: "Ratio of rows with invalid durations."
  }

  measure: extreme_duration_count {
    type: sum
    sql: CASE WHEN ${TABLE}.duration_minutes > 1440 THEN 1 ELSE 0 END ;;
    description: "Number of rows with duration > 24 hours (1440 minutes)."
  }

  measure: extreme_duration_ratio {
    type: number
    sql: 1.0 * ${extreme_duration_count} / NULLIF(${count}, 0) ;;
    value_format_name: percent_2
    description: "Ratio of rows with extreme durations (> 24h)."
  }

  # Uniqueness / Duplicate IDs
  measure: duplicate_trip_ids_count {
    type: number
    sql: ${count} - COUNT(DISTINCT ${TABLE}.trip_id) ;;
    description: "Number of duplicate trip ID records found in the table."
  }
}
