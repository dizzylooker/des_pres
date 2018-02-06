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
  label: "Rental Analysis"
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
  join: store {
    relationship: many_to_one
    sql_on: ${customer.store_id} = ${store.store_id} ;;
  }
  join: country {
    relationship: many_to_one
    sql_on: ${customer_list.country} = ${country.country_id} ;;
  }
}
