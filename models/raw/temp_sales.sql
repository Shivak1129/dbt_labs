{{ config(materialized='ephemeral') }}

SELECT
    PRODUCT_ID,
    CUSTOMER_ID,
    QUANTITY,
    SALE_DATE
FROM {{ source('sale_data', 'SALES_TRANSACTIONS') }}
WHERE SALE_DATE IS NOT NULL
