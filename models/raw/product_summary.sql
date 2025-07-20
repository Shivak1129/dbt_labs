-- File: models/marts/fct_recent_sales_revenue.sql
{{ config(
    materialized='table',
    schema='clean_schema',
    database='DBT_Clean'
) }}

SELECT
    s.CUSTOMER_ID,
    p.PRODUCT_NAME,
    p.CATEGORY,
    p.PRICE,
    s.QUANTITY,
    s.SALE_DATE,
    (s.QUANTITY * p.PRICE) AS TOTAL_REVENUE
FROM {{ ref('temp_sales') }} s
JOIN {{ ref('prod_info') }} p
    ON s.PRODUCT_ID = p.PRODUCT_ID
WHERE s.SALE_DATE >= DATEADD(month, -15, CURRENT_DATE)
