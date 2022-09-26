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
        clicked_items,
        count(*) over (
            partition by order_number
            order by order_datetime desc
        ) as order_count
    from source
),

deduped as (

    select *
    from staged
    where order_count = 1

)

select * from deduped