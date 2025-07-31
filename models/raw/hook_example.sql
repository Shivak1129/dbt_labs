
SELECT
    customer_id,
    full_name,
    email,
    gender,
    age,
    city,
    state,
    registered_on
FROM {{ source('tele_customer', 'TELECOM_CUSTOMERS') }}
