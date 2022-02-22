with bank_accounts as (
    select * from {{ ref('stg_bank_accounts') }}
)

select 
    len(bank_account_number) as acct_number_length,
    len(routing_number) as routing_number_length
from bank_accounts
where acct_number_length != 9
or routing_number_length != 9