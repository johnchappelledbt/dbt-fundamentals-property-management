with leases_executed as (
    select * from {{ ref('fct_leases__executed') }}
),

prev_row_unit_leased as (
    select
        tenant_id,
        lag(unit_leased, 1) over (partition by tenant_id order by unit_leased) as prev_row_unit
    from leases_executed
),

prev_row_move_in_date as (
    select
        tenant_id,
        lag(move_in_date, 1) over (partition by tenant_id order by unit_leased) as prev_row_date
    from leases_executed
)

select
    leases_executed.tenant_id,
    leases_executed.unit_leased,
    prev_row_unit_leased.prev_row_unit as last_unit,
    leases_executed.move_in_date,
    prev_row_move_in_date.prev_row_date as last_date
from leases_executed
join prev_row_unit_leased on prev_row_unit_leased.tenant_id = leases_executed.tenant_id
join prev_row_move_in_date on prev_row_move_in_date.tenant_id = leases_executed.tenant_id
where last_unit = unit_leased
and last_date != move_in_date
