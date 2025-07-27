SELECT
    plan_id,
    customer_id,
    activated_on,
    validity_days,
    {{ calculate_expiry('activated_on', 'validity_days') }} AS expiry_date
FROM {{ source('tele_telecom_plans', 'TELE_PLANS') }}
