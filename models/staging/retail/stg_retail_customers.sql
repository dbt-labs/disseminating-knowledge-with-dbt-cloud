with

source as (
    select * from {{ source('retail','customers')}}
),

staged as (
    select 
        customer_id,
        loyalty_segment as loyalty_segment_id,
        -- tax_id,
        -- tax_code,
        customer_name,

        -- location information
        state,
        city,
        postcode as zipcode,
        street,
        number,
        unit,
        region,
        district,
        lon as longitude,
        lat as latitude,

        ship_to_address,

        -- meta
        valid_from,
        valid_to
    from source
)

select * from staged