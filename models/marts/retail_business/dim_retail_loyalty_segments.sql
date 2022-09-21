with

segments as (

    select * from {{ ref('stg_retail_loyalty_segments') }}

),

customers as (

    select * from {{ ref('dim_retail_customers') }}

),

segment_customers as (

    select 
        loyalty_segment_id,
        count(*) as number_of_customers,
        sum(customer_total) as segment_total,
        sum(total_units_bought) as segment_units_bought,
        avg(total_units_bought) as avg_units_per_customer
    from customers
    group by 1
    order by 1
),

final as (

    select
        segments.*,
        number_of_customers,
        segment_total,
        segment_units_bought,
        avg_units_per_customer

    from segments
    left join segment_customers on segments.loyalty_segment_id = segment_customers.loyalty_segment_id

)

select * from final