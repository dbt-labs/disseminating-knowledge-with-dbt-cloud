with

customers as (

    select * from {{ ref('stg_retail__customers') }}

),

orders as (

    select * from {{ ref('fct_retail_orders') }}

),

aggregated as (

    select
        customer_id,
        count(*) as number_of_orders,
        min(order_datetime) as first_order_date,
        max(order_datetime) as last_order_date,
        sum(order_total) as customer_total,
        sum(order_total_items) as total_units_bought
    from orders
    group by 1
    order by 1

),

joined as (

    select 
        customers.*,
        aggregated.number_of_orders,
        aggregated.first_order_date,
        aggregated.last_order_date,
        aggregated.customer_total,
        aggregated.total_units_bought
    from customers
    left join aggregated using(customer_id)
    order by 1
)

select * from joined
