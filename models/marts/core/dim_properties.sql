with properties as (
    select
        property_id,
        created_at,
        type,
        address,
        year_built 
    from {{ ref('stg_properties') }}
),

property_owners as (
    select
        property_id,
        owner_id
    from {{ ref('stg_property_owners') }}
),

units as (
    select
        property_id,
        unit_id,
        rent,
        name,
        bedrooms,
        bathrooms,
        square_feet,
        status,
        address_1,
        address_2,
        city,
        state,
        zip_code
    from {{ ref('stg_units') }}
),

final as (
    select
        properties.*,
        property_owners.owner_id,
        units.unit_id,
        units.rent,
        units.name,
        units.bedrooms,
        units.bathrooms,
        units.square_feet,
        units.status,
        units.address_1,
        units.address_2,
        units.city,
        units.state,
        units.zip_code

    from properties
    left join units on units.property_id = properties.property_id
    left join property_owners on property_owners.property_id = properties.property_id
    order by 1
)

select * from final