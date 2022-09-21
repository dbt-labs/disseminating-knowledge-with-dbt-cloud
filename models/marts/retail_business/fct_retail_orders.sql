with

sales_orders as (

    select * from {{ ref('stg_retail_sales_orders') }}

),

order_items as (

    select * from {{ ref('int_retail_order_items') }}

),

aggregated as (

    select 
        order_id,
        count(*) as number_of_unique_items,
        sum(items_total) as order_total,
        sum(quantity) as order_total_items

    from order_items
    group by 1
    order by 1

),

joined as (

    select 
        sales_orders.order_id,
        sales_orders.customer_id,
        sales_orders.customer_name,
        sales_orders.number_of_line_items,
        sales_orders.order_datetime,
        aggregated.order_total,
        aggregated.order_total_items,
        aggregated.number_of_unique_items
    from sales_orders
    left join aggregated using(order_id)
    order by 1
    
)

select * from joined