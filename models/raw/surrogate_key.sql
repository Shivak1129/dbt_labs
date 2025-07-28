SELECT
    *,
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'plan_id']) }} AS customer_plan_sk
FROM {{ source('tele_telecom_plans', 'TELE_PLANS') }}
