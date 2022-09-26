with

sales_orders as (

    select * from {{ ref('stg_retail_sales_orders') }}

),

exploded as (

    select
        order_id,
        customer_id,
        explode(ordered_products) as item_details
    from sales_orders

),

order_items as (

    select
        order_id,
        customer_id,
        item_details.id as product_id,
        item_details.curr as currency,
        item_details.name as product_name,
        item_details.price as price,
        item_details.promotion_info as promo_info,
        item_details.qty as quantity,
        item_details.unit as unit,
        item_details.price * item_details.qty as items_total
    from exploded

),

-- adding surrogate key to test for uniqueness

final as (
    select
        {{ dbt_utils.surrogate_key(['order_id','customer_id','product_id','price']) }} as order_item_id,
        *
    from order_items
)

select * from final