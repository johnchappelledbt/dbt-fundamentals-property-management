with tenants as (
    select * from {{ ref('stg_tenants') }}
),

bank_accounts as (
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

final as (
    select
      tenants.*,
      bank_accounts.bank_name,
      bank_accounts.bank_account_number,
      bank_accounts.routing_number,
      contact_infos.first_name,
      contact_infos.last_name,
      contact_infos.email_address,
      contact_infos.phone_number
    from tenants
    left join bank_accounts on bank_accounts.bank_account_id = tenants.bank_account_id
    left join contact_infos on contact_infos.contact_info_id = tenants.contact_info_id
)

select * from final
