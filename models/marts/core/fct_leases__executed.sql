with rental_applications as (
    select
        contact_info_id,
        status
    from {{ ref('stg_rental_applications') }}
),

tenants as (
    select 
        contact_info_id,
        lease_id
    from {{ ref('dim_tenants') }}
),

leases as (
    select
        lease_id,
        completed
    from {{ ref('stg_leases') }}
),

final as (
    select
        leases.lease_id,
        rental_applications.status as rental_status
    from leases
    left join tenants on tenants.lease_id = leases.lease_id
    join rental_applications on rental_applications.contact_info_id = tenants.contact_info_id
    where leases.completed = true
)

select * from final