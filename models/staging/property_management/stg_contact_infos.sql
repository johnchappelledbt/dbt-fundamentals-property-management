with contact_infos as (
    select
      id as contact_info_id,
      created_at,
      first_name,
      last_name,
      email_address,
      phone_number

    from {{ source ('property_management','contact_infos')}}
)

select * from contact_infos