with vendors as (
    select 
      id as vendor_id,
      created_at,
      contact_info_id,
      bank_account_id
    from {{ source ('property_management','vendors')}}
)

select * from vendors