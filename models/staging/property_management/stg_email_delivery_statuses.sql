with email_delivery_statuses as (
    select 
        id as delivery_status_id,
        created_at,
        event as status,
        email_id
    from {{ source ('property_management','email_delivery_statuses')}}
)

select * from email_delivery_statuses