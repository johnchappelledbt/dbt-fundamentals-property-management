with property_owners as (
    select * from {{ source ('property_management','property_owners')}}
)

select * from property_owners