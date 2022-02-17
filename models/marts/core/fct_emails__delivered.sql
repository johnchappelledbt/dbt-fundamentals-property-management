with emails as (
    select
      email_id, 
      created_at,
      sent_at,
      subject,
      body,
      delivered_at 
    from {{ ref('stg_emails')}}
),

email_delivery_statuses as (
    select 
      email_id,
      status
    from {{ ref('stg_email_delivery_statuses')}}
),

final as (
    select 
        emails.*
    from emails
    left join email_delivery_statuses using (email_id)
    where email_delivery_statuses.status = 'delivered'
)

select * from final