with transactions as (
    select 
      id as transaction_id,
      created_at,
      deleted_at,
      type,
      amount,
      payer,
      payee
    from {{ source ('property_management','transactions')}}
)

select * from transactions