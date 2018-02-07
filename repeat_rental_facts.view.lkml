view: repeat_rental_facts {
  derived_table: {
    indexes: ["rental_id"]
    sql_trigger_value: SELECT MAX(rental.rental_date) FROM sakila.rental ;;
    # ADD IN MORE CUSTOMER ID RATHER THAN RETNA
    sql: SELECT
      rental.customer_id AS customer_id
      , rental.rental_id AS rental_id
      , MIN(repeat_rental.rental_date) AS next_rental_date
      , MIN(repeat_rental.rental_id) AS next_rental_id
    FROM sakila.rental rental
    JOIN sakila.rental repeat_rental
    ON rental.customer_id = repeat_rental.customer_id
    WHERE rental.rental_date < repeat_rental.rental_date
    GROUP BY 1
       ;;
  }

  dimension: rental_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.rental_id ;;
  }

  dimension: next_rental_id {
    type: number
    hidden: yes
    sql: ${TABLE}.next_rental_id ;;
  }

  dimension: has_subsequent_rental {
    type: yesno
    sql: ${next_rental_id} > 0 ;;
  }

  dimension_group: next_rental {
    type: time
    timeframes: [date]
    hidden: yes
    sql: ${TABLE}.next_rental_date ;;
  }
}
