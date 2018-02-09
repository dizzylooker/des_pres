view: rental {
  sql_table_name: sakila.rental ;;

  dimension: rental_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.rental_id ;;
  }

  dimension: customer_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: inventory_id {
    type: number
    sql: ${TABLE}.inventory_id ;;
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

  dimension_group: rental {
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
    sql: ${TABLE}.rental_date ;;
  }

  dimension_group: return {
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
    sql: ${TABLE}.return_date ;;
  }

  dimension: staff_id {
    type: yesno
    sql: ${TABLE}.staff_id ;;
  }

  measure: count {
    type: count
    drill_fields: [rental_id, customer.last_name, customer.first_name, customer.customer_id, payment.count]
  }

  dimension: rental_length {
    type: number
    sql: ${return_date} - ${rental_date} ;;
  }

  dimension: is_late {
    type: yesno
    sql: ${rental_length} > 7;;
  }

  measure: average_rental_length {
    type: average
    sql: ${rental_length} ;;
  }

# Repeat Rentals

  dimension: days_until_next_rental {
    type: number
    view_label: "Repeat Rental Facts"
    sql: DATEDIFF(${rental_date},${repeat_rental_facts.next_rental_date}) ;;
  }

  dimension: repeat_rentals_within_30d {
    type: yesno
    view_label: "Repeat Rental Facts"
    sql: ${days_until_next_rental} <= 30 ;;
  }

  measure: count_with_repeat_purchase_within_30d {
    type: count_distinct
    sql: ${customer_id} ;;
    view_label: "Repeat Rental Facts"

    filters: {
      field: repeat_rentals_within_30d
      value: "Yes"
    }
  }

  measure: 30_day_repeat_rental_rate {
    description: "The percentage of members who rent again within 30 days"
    view_label: "Repeat Rental Facts"
    type: number
    value_format_name: percent_1
    sql: 1.0 * ${count_with_repeat_purchase_within_30d} / NULLIF(${count},0) ;;
#    drill_fields: [products.brand, rental_count, count_with_repeat_purchase_within_30d]
  }
}
