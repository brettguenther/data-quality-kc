view: austin_bikeshare_trips_dq_results {
  sql_table_name: `stellar-cumulus-449523-b8.dataplex_dq_demo.austin_bikeshare_trips_dq_results` ;;

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${TABLE}.data_quality_job_id, '_', COALESCE(${TABLE}.rule_column, 'col'), '_', ${TABLE}.rule_dimension, '_', COALESCE(${TABLE}.rule_name, 'rule')) ;;
  }

  dimension: data_quality_job_id {
    type: string
    sql: ${TABLE}.data_quality_job_id ;;
    description: "Unique identifier for the Dataplex scan job run."
  }

  dimension_group: job_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.job_start_time ;;
    description: "Start time of the data quality scan job."
  }

  dimension_group: job_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.job_end_time ;;
    description: "End time of the data quality scan job."
  }

  dimension: rule_name {
    type: string
    sql: ${TABLE}.rule_name ;;
    description: "Name of the data quality rule."
  }

  dimension: rule_description {
    type: string
    sql: ${TABLE}.rule_description ;;
    description: "Description of the data quality rule."
  }

  dimension: rule_type {
    type: string
    sql: ${TABLE}.rule_type ;;
    description: "Type of rule (e.g., NonNull, Range, Regex)."
  }

  dimension: rule_column {
    type: string
    sql: ${TABLE}.rule_column ;;
    description: "The column in the source table evaluated by this rule."
  }

  dimension: rule_dimension {
    type: string
    sql: ${TABLE}.rule_dimension ;;
    description: "The category of the rule (COMPLETENESS, VALIDITY, etc.)."
  }

  dimension: rule_passed {
    type: yesno
    sql: ${TABLE}.rule_passed ;;
    description: "Whether the rule evaluation succeeded based on its threshold."
  }

  dimension: rule_rows_evaluated {
    type: number
    sql: ${TABLE}.rule_rows_evaluated ;;
    description: "Number of rows evaluated by this rule."
  }

  dimension: rule_rows_passed {
    type: number
    sql: ${TABLE}.rule_rows_passed ;;
    description: "Number of rows that passed this rule."
  }

  dimension: rule_rows_failed {
    type: number
    sql: ${TABLE}.rule_rows_evaluated - ${TABLE}.rule_rows_passed ;;
    description: "Number of rows that failed this rule."
  }

  dimension: rule_rows_null {
    type: number
    sql: ${TABLE}.rule_rows_null ;;
    description: "Number of rows containing null values for this rule."
  }

  dimension: rule_rows_passed_percent {
    type: number
    sql: ${TABLE}.rule_rows_passed_percent ;;
    description: "Percentage of rows that passed this rule."
    value_format_name: percent_2
  }

  dimension: rule_failed_records_query {
    type: string
    sql: ${TABLE}.rule_failed_records_query ;;
    description: "SQL query to retrieve the failed records for this rule."
  }

  # --- Measures ---

  measure: count {
    type: count
    drill_fields: [data_quality_job_id, rule_name, rule_column, rule_dimension, rule_passed]
    description: "Total count of individual rule evaluations."
  }

  measure: job_count {
    type: count_distinct
    sql: ${TABLE}.data_quality_job_id ;;
    description: "Total count of unique data quality scan jobs."
  }

  measure: total_rows_evaluated {
    type: sum
    sql: ${TABLE}.rule_rows_evaluated ;;
    description: "Total rows evaluated across all rules."
  }

  measure: total_rows_passed {
    type: sum
    sql: ${TABLE}.rule_rows_passed ;;
    description: "Total rows that passed evaluation across all rules."
  }

  measure: total_rows_failed {
    type: sum
    sql: ${TABLE}.rule_rows_evaluated - ${TABLE}.rule_rows_passed ;;
    description: "Total rows that failed evaluation across all rules."
  }

  measure: total_rows_null {
    type: sum
    sql: ${TABLE}.rule_rows_null ;;
    description: "Total null rows observed across all rules."
  }

  measure: average_passed_percent {
    type: average
    sql: ${TABLE}.rule_rows_passed_percent ;;
    value_format_name: percent_2
    description: "Average pass percentage across all rule runs."
  }

  measure: passed_rules_count {
    type: count
    filters: [rule_passed: "yes"]
    description: "Count of individual rule runs that passed."
  }

  measure: failed_rules_count {
    type: count
    filters: [rule_passed: "no"]
    description: "Count of individual rule runs that failed."
  }

  measure: rule_success_rate {
    type: number
    sql: 1.0 * ${passed_rules_count} / NULLIF(${count}, 0) ;;
    value_format_name: percent_2
    description: "Percentage of rules that passed successfully."
  }
}
