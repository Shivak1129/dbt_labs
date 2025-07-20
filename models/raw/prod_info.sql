{{
    config(
        query_tag='dbt'
    )
}}

SELECT
    c.CUSTOMER_ID,
    c.FIRST_NAME,
    c.LAST_NAME,
    c.EMAIL,
    p.PRODUCT_ID,
    p.PRODUCT_NAME,
    p.CATEGORY,
    p.PRICE,
    p.PURCHASE_DATE
FROM {{ source('raw_data', 'CUSTOMER') }} c
JOIN {{ source('prod_data', 'PRODUCT') }} p
    ON c.CUSTOMER_ID = p.CUSTOMER_ID
