-- models/raw/orders_insert_overwrite.sql

{{
  config(
    query_tag = 'dbt',
    partition_by={"field": "ORDER_DATE", "data_type": "date"}
  )
}}

SELECT 
    *
FROM {{ source('order_data', 'orders') }}
{% if is_incremental() %}
    WHERE ORDER_DATE >= COALESCE(
        (SELECT MAX(ORDER_DATE) FROM {{ this }}),
        '1900-01-01'  -- fallback for first run
    )
{% endif %}

