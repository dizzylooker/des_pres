view: payment {
  sql_table_name: sakila.payment ;;

  dimension: payment_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.payment_id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: customer_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_update ;;
  }

  dimension_group: payment {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.payment_date ;;
  }

  dimension: rental_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.rental_id ;;
  }

  dimension: staff_id {
    type: yesno
    sql: ${TABLE}.staff_id ;;
  }

  measure: count {
    type: count
    drill_fields: [payment_id, rental.rental_id, customer.last_name, customer.first_name, customer.customer_id]
  }

  measure: total_revenue {
    type: sum
    value_format_name: usd_0
    sql: ${amount} ;;
    link: {
      label: "Revenue Dashboard"
      url: "https://saleseng.dev.looker.com/dashboards/171"
      # ADD FILTERS BACK? ?State={{ _filters['users.state'] | url_encode }}&Age={{ _filters['users.age'] | url_encode }}"
    }
  }

  measure: percentage_of_total_revenue {
    type: percent_of_total
    sql: ${amount} ;;
  }

  measure: average_revenue {
    type: average
    sql: ${amount} ;;
  }

  parameter: measure_type {
    # Or name allowed_values
    suggestions: ["Total Revenue","Average Revenue","Transaction Count","Min Transaction","Max Transaction"]
  }

  measure: key_metric {
    type: number
    sql: case when  {% condition measure_type %} 'Total Revenue' {% endcondition %}  then sum( ${TABLE}.amount)
          when {% condition measure_type %} 'Average Revenue' {% endcondition %}  then avg( ${TABLE}.amount)
          when {% condition measure_type %} 'Transaction Count' {% endcondition %}  then count( ${TABLE}.amount)
          when {% condition measure_type %} 'Min Transaction' {% endcondition %}  then min( ${TABLE}.amount)
          when {% condition measure_type %} 'Max Transaction' {% endcondition %}  then max( ${TABLE}.amount)
          else null end;;
  }
}
