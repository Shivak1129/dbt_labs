with 

source as (

    select * from {{ source('raw_data', 'CUSTOMER') }}

),

renamed as (

    select
        customer_id,
        first_name,
        last_name,
        gender,
        date_of_birth,
        email,
        phone,
        city,
        state,
        pincode,
        created_at

    from source

)

select * from renamed
