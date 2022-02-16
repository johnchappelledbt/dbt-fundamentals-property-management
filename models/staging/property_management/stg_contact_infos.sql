with contact_infos as (
    select * from {{ source ('property_management','contact_infos')}}
)

select * from contact_infos