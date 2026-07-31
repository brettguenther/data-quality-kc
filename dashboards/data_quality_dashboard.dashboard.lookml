- dashboard: data_quality_dashboard
  title: Dataplex Data Quality Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next

  tabs:
    - name: dq_metrics
      label: "Data Quality Scan Results"
    - name: bikeshare_analytics
      label: "Bikeshare Analytics"

  elements:
    # --- Tab 1: Data Quality Scan Results ---
    - name: total_rules_evaluated
      tab_name: dq_metrics
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
      tab_name: dq_metrics
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
      tab_name: dq_metrics
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
      tab_name: dq_metrics
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
      tab_name: dq_metrics
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
      tab_name: dq_metrics
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
      tab_name: dq_metrics
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

    # --- Tab 2: Bikeshare Analytics ---
    - name: total_trips_kpi
      tab_name: bikeshare_analytics
      title: Total Trips
      model: data_quality_kc
      explore: austin_bikeshare_trips
      type: single_value
      fields: [austin_bikeshare_trips.count]
      limit: 500
      row: 0
      col: 0
      width: 8
      height: 4

    - name: avg_duration_kpi
      tab_name: bikeshare_analytics
      title: Avg Duration (Min)
      model: data_quality_kc
      explore: austin_bikeshare_trips
      type: single_value
      fields: [austin_bikeshare_trips.average_duration]
      limit: 500
      row: 0
      col: 8
      width: 8
      height: 4

    - name: electric_bike_trips_kpi
      tab_name: bikeshare_analytics
      title: Electric Bike Trips
      model: data_quality_kc
      explore: austin_bikeshare_trips
      type: single_value
      fields: [austin_bikeshare_trips.electric_bike_trips]
      limit: 500
      row: 0
      col: 16
      width: 8
      height: 4

    - name: trips_timeline
      tab_name: bikeshare_analytics
      title: Daily Trip Volume
      model: data_quality_kc
      explore: austin_bikeshare_trips
      type: looker_line
      fields: [austin_bikeshare_trips.start_date, austin_bikeshare_trips.count]
      sorts: [austin_bikeshare_trips.start_date desc]
      limit: 500
      row: 4
      col: 0
      width: 24
      height: 8

    - name: popular_start_stations
      tab_name: bikeshare_analytics
      title: Top 10 Start Stations
      model: data_quality_kc
      explore: austin_bikeshare_trips
      type: looker_bar
      fields: [austin_bikeshare_trips.start_station_name, austin_bikeshare_trips.count]
      sorts: [austin_bikeshare_trips.count desc]
      limit: 10
      row: 12
      col: 0
      width: 12
      height: 8

    - name: subscriber_vs_casual
      tab_name: bikeshare_analytics
      title: Trips by User Type
      model: data_quality_kc
      explore: austin_bikeshare_trips
      type: looker_donut
      fields: [austin_bikeshare_trips.subscriber_type, austin_bikeshare_trips.count]
      sorts: [austin_bikeshare_trips.count desc]
      limit: 10
      row: 12
      col: 12
      width: 12
      height: 8
