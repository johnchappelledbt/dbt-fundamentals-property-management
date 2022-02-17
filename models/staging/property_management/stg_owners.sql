with owners as (
    select
      id as owner_id,
      created_at,
      contact_info_id,
      bank_account_id
    from {{ source ('property_management','owners')}}
)

select * from owners