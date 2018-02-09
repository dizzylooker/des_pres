view: customer_list {
  sql_table_name: sakila.customer_list ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: sid {
    type: yesno
    sql: ${TABLE}.SID ;;
  }

  dimension: zip_code {
    type: zipcode
    sql: ${TABLE}.`zip code` ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
