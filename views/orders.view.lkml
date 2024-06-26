# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes

    type: number
    sql: ${TABLE}.id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: first_provider_visit{
    # label: "First Provider Visit"
    description: "Date of the first non-cancelled visit with a provider for a patient"
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      hour,
      day_of_week,
      day_of_week_index,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Status" in Explore.

  dimension: status {
    type: string
drill_fields: [user_id,id]
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    link: {
      label: "Drill test"
      url: "
      {% if status._value == 'COMPLETED' %}
      https://gcpl240.cloud.looker.com/dashboards/59
      {% elsif status._value == 'CANCELLED' %}
      https://gcpl240.cloud.looker.com/dashboards/59
      {% endif %}
      "
      icon_url: "https://lh3.googleusercontent.com/LB46lrUI6NnAoPcUzKKuSFpaxh88gOgqvzKuf4P69wcRse542XNch2t6FYUu=s48-c"}
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.id,
  users.first_name,
  users.last_name,
  billion_orders.count,
  fakeorders.count,
  hundred_million_orders.count,
  hundred_million_orders_wide.count,
  order_items.count,
  order_items_vijaya.count,
  ten_million_orders.count
  ]
  }

}
