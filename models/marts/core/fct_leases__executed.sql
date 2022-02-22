with rental_applications as (
    select
        contact_info_id,
        status
    from {{ ref('stg_rental_applications') }}
),

tenants as (
    select 
        tenant_id,
        move_in_date,
        move_out_date,
        contact_info_id,
        lease_id
    from {{ ref('dim_tenants') }}
),

leases as (
    select
        lease_id,
        unit_id,
        start_date,
        end_date,
        completed
    from {{ ref('stg_leases') }}
),

final as (
    select
        leases.lease_id,
        rental_applications.status as rental_status,
        leases.start_date as lease_start_date,
        leases.end_date as lease_end_date,
        leases.unit_id as unit_leased,
        tenants.tenant_id,
        tenants.move_in_date,
        tenants.move_out_date
    from leases
    left join tenants on tenants.lease_id = leases.lease_id
    join rental_applications on rental_applications.contact_info_id = tenants.contact_info_id
    where leases.completed = true
)

select * from final