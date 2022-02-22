with tenants as (
    select 
        contact_info_id,
        lease_id,
        concat(first_name, ' ', last_name) as full_name
    from {{ ref('dim_tenants') }}
),

leases as (
    select
        lease_id,
        unit_id
    from {{ ref('stg_leases') }}
),

units as (
    select
        unit_id,
        rent
    from {{ ref('stg_units') }}
),

transactions as (

    select 
        transaction_id, 
        created_at, 
        type,
        amount,
        payer,
        payee 
    from {{ ref('stg_transactions') }}

),

final as (
    select
        transactions.transaction_id,
        transactions.payer,
        transactions.payee,
        leases.unit_id,
        units.rent,
        transactions.amount as amount_paid,
        transactions.created_at as date_paid,
        transactions.type as transaction_type

    from transactions
    left join tenants on tenants.full_name = transactions.payer
    join leases on leases.lease_id = tenants.lease_id
    join units on units.unit_id = leases.lease_id
    order by payer asc, date_paid desc

)

select * from final