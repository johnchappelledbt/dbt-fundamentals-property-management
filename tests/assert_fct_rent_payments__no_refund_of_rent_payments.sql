with rent_payments as (
    select * from {{ ref('fct_rent_payments') }}
)

select
    transaction_type,
    amount_paid
from rent_payments
where transaction_type = 'charge'
and amount_paid < 0