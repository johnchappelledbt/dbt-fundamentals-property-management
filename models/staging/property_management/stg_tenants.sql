with tenants as (
    select 
      id as tenant_id,
      created_at,
      contact_info_id,
      bank_account_id,
      move_out_date,
      notice_date,
      lease_id
    from {{ source ('property_management','tenants')}}
)

select * from tenants