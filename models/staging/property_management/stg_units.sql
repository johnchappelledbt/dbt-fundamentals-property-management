with units as (
    select * from {{ source ('property_management','units')}}
)

select * from units