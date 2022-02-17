with bank_accounts as (
    select 
        bank_account_id,
        bank_name,
        bank_account_number,
        routing_number
    from {{ ref('stg_bank_accounts') }}
),

contact_infos as (
    select
        contact_info_id,
        first_name,
        last_name,
        email_address,
        phone_number
    from {{ ref('stg_contact_infos') }}
),

owners as (
    select * from {{ ref('stg_owners') }}
),

final as (
    select
        owners.*,
        contact_infos.first_name,
        contact_infos.last_name,
        contact_infos.email_address,
        contact_infos.phone_number,
        bank_accounts.bank_name,
        bank_accounts.bank_account_number,
        bank_accounts.routing_number
    from owners
    left join contact_infos on contact_infos.contact_info_id = owners.contact_info_id
    left join bank_accounts on bank_accounts.bank_account_id = owners.bank_account_id
)

select * from final