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

  # --- Measures ---

  measure: count {
    type: count
    label: "Total Trips"
    drill_fields: [trip_id, start_station_name, end_station_name, duration_minutes]
  }

  measure: average_duration {
    type: average
    sql: ${TABLE}.duration_minutes ;;
    value_format_name: decimal_1
    description: "Average trip duration in minutes."
  }

  measure: total_duration {
    type: sum
    sql: ${TABLE}.duration_minutes ;;
    value_format_name: decimal_0
    description: "Total ride duration in minutes."
  }

  measure: subscriber_trips_count {
    type: count
    filters: [subscriber_type: "Local 31 Day, Local 365, Local 31 Day (FY25), Local 365 (FY25), Student Membership, Founder Member"]
    description: "Count of trips made by members with subscriber-like profiles."
  }

  measure: non_subscriber_trips_count {
    type: count
    filters: [subscriber_type: "-Local 31 Day, -Local 365, -Local 31 Day (FY25), -Local 365 (FY25), -Student Membership, -Founder Member"]
    description: "Count of trips made by casual or single-use riders."
  }

  measure: classic_bike_trips {
    type: count
    filters: [bike_type: "classic"]
    description: "Trips made using classic (non-electric) bikes."
  }

  measure: electric_bike_trips {
    type: count
    filters: [bike_type: "electric"]
    description: "Trips made using electric bikes."
  }
}
