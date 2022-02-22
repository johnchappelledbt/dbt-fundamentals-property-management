with properties as (
    select 
      id as property_id,
      created_at,
      address,
      state,
      zip_code,
      type,
      year_built

    from {{ source ('property_management','properties')}}
)

select * from properties