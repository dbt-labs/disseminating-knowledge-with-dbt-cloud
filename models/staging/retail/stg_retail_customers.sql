with

source as (
    select * from {{ source('retail','customers')}}
    where valid_to is null -- only bring in the most up to date customer record
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
        from_unixtime(valid_from) as valid_from, -- Convert from EPOCH time to TimeDate UTC
        valid_to
    from source
)

select * from staged