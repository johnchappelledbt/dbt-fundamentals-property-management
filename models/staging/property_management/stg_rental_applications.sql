with rental_applications as (
    select * from {{ source ('property_management','rental_applications')}}
)

select * from rental_applications