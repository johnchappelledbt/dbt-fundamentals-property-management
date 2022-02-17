with leases as (
    select 
      id as lease_id,
      created_at,
      unit_id,
      start_date,
      end_date,
      completed
    from {{ source ('property_management','leases')}}
)

select * from leases