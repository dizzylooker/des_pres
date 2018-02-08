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
  }

  measure: percentage_of_total_revenue {
    type: percent_of_total
    sql: ${amount} ;;
  }

  measure: average_revenue {
    type: average
    sql: ${amount} ;;
  }

# Dynamic filters

  measure: key_metric {
    type: sum
    sql: ${TABLE}.{% parameter chosen_metric %};;
  }

  parameter: chosen_metric {
    type: unquoted
    allowed_value: {
      label: "Count"
      value: "count"
    }
    allowed_value: {
      label: "Average Revenue"
      value: "average_revenue"
    }
    allowed_value: {
      label: "Total Revenue"
      value: "total_revenue"
    }
  }
}
