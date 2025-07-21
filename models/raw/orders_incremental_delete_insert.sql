{{ config(
    unique_key = "order_id",
    query_tag = 'dbt'
) }}

SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    amount
FROM {{ source('order_data', 'orders') }}
{% if is_incremental() %}
WHERE order_date >= DATEADD(day, -30, CURRENT_DATE)
{% endif %}

