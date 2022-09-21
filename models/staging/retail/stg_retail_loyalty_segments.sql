with

source as (
    select * from {{ source('retail','loyalty_segments')}}
),

staged as (
    select 
        loyalty_segment_id,
        loyalty_segment_description,
        unit_threshold,
        valid_from,
        valid_to
    from source
)

select * from staged