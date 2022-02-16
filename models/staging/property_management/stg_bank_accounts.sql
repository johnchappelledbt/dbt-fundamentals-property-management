with bank_accounts as (
    select * from {{ source('property_management', 'bank_accounts') }}
)

select * from bank_accounts