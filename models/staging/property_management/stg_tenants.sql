with tenants as (
    select * from {{ source ('property_management','tenants')}}
)

select * from tenants