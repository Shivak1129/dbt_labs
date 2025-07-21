{{ config(
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
WHERE order_id > (SELECT MAX(order_id) FROM {{ this }})
{% endif %}
