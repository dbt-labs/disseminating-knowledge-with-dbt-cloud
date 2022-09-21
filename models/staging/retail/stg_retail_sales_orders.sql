with

source as (

    select * from {{ source('retail', 'sales_orders') }}

),

staged as (

    select 
        order_number as order_id,
        customer_id,
        customer_name,
        number_of_line_items,
        order_datetime,
        ordered_products,
        promo_info,
        clicked_items
    from source
)

select * from staged