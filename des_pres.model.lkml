connection: "video_store"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
explore: rental {
  group_label: "Des Video"
  label: "Revenue Analysis"
  join: customer {
    relationship: many_to_one
    sql_on: ${rental.customer_id} = ${customer.customer_id} ;;
  }
  join: customer_list {
    relationship: one_to_one
    sql_on: ${customer.customer_id} = ${customer_list.id} ;;
  }
  join: payment {
    relationship: one_to_many
    sql_on: ${customer.customer_id} = ${payment.customer_id} ;;
  }
  join: repeat_rental_facts {
    relationship: one_to_one
    sql_on: ${rental.rental_id} = ${repeat_rental_facts.rental_id} ;;
  }
  join: inventory {
    relationship: one_to_many
    sql_on: ${rental.inventory_id} = ${inventory.inventory_id} ;;
  }
  join: film {
    relationship: many_to_one
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
  }
  join: film_list {
    relationship: one_to_one
    sql_on: ${film.film_id} = ${film_list.fid} ;;
  }
  join: store {
    relationship: many_to_one
    sql_on: ${inventory.store_id} = ${inventory.store_id} ;;
  }
}
