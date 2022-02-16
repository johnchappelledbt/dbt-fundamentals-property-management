with properties as (
    select * from {{ source ('property_management','properties')}}
)

select * from properties