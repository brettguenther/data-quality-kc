- dashboard: data_quality_dashboard
  title: Dataplex Data Quality Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next

  elements:
    - name: total_rules_evaluated
      title: Total Rules Evaluated
      model: data_quality_kc
      explore: austin_bikeshare_trips_dq_results
      type: single_value
      fields: [austin_bikeshare_trips_dq_results.count]
      limit: 500
      row: 0
      col: 0
      width: 8
      height: 4

    - name: total_failed_rules
      title: Failed Rules
      model: data_quality_kc
      explore: austin_bikeshare_trips_dq_results
      type: single_value
      fields: [austin_bikeshare_trips_dq_results.failed_rules_count]
      limit: 500
      row: 0
      col: 8
      width: 8
      height: 4

    - name: overall_success_rate
      title: Overall Success Rate
      model: data_quality_kc
      explore: austin_bikeshare_trips_dq_results
      type: single_value
      fields: [austin_bikeshare_trips_dq_results.rule_success_rate]
      limit: 500
      row: 0
      col: 16
      width: 8
      height: 4

    - name: success_rate_trend
      title: Rule Success Rate Trend
      model: data_quality_kc
      explore: austin_bikeshare_trips_dq_results
      type: looker_line
      fields: [austin_bikeshare_trips_dq_results.job_start_date, austin_bikeshare_trips_dq_results.rule_success_rate]
      sorts: [austin_bikeshare_trips_dq_results.job_start_date desc]
      limit: 500
      row: 4
      col: 0
      width: 24
      height: 8

    - name: failures_by_dimension
      title: Rule Failures by Dimension
      model: data_quality_kc
      explore: austin_bikeshare_trips_dq_results
      type: looker_column
      fields: [austin_bikeshare_trips_dq_results.rule_dimension, austin_bikeshare_trips_dq_results.failed_rules_count]
      sorts: [austin_bikeshare_trips_dq_results.failed_rules_count desc]
      limit: 500
      row: 12
      col: 0
      width: 12
      height: 8

    - name: failures_by_column
      title: Rule Failures by Column
      model: data_quality_kc
      explore: austin_bikeshare_trips_dq_results
      type: looker_column
      fields: [austin_bikeshare_trips_dq_results.rule_column, austin_bikeshare_trips_dq_results.failed_rules_count]
      sorts: [austin_bikeshare_trips_dq_results.failed_rules_count desc]
      limit: 500
      row: 12
      col: 12
      width: 12
      height: 8

    - name: detailed_results_table
      title: Detailed Rule Run Results
      model: data_quality_kc
      explore: austin_bikeshare_trips_dq_results
      type: looker_grid
      fields: [
        austin_bikeshare_trips_dq_results.data_quality_job_id,
        austin_bikeshare_trips_dq_results.job_start_time,
        austin_bikeshare_trips_dq_results.rule_dimension,
        austin_bikeshare_trips_dq_results.rule_column,
        austin_bikeshare_trips_dq_results.rule_name,
        austin_bikeshare_trips_dq_results.rule_rows_evaluated,
        austin_bikeshare_trips_dq_results.rule_rows_passed,
        austin_bikeshare_trips_dq_results.rule_rows_null,
        austin_bikeshare_trips_dq_results.rule_passed
      ]
      sorts: [austin_bikeshare_trips_dq_results.job_start_time desc]
      limit: 500
      row: 20
      col: 0
      width: 24
      height: 10
