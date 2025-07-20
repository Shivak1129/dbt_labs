{{ config(
   query_tag = 'dbt'
) }}

SELECT
    CUSTOMER_ID as CUST_ID, FIRST_NAME, LAST_NAME, FIRST_NAME || ' ' || LAST_NAME as FULL_NAME,
    EMAIL, PHONE AS PHN_NUMBER, CITY, STATE
FROM {{ source('raw_data', 'CUSTOMER') }}