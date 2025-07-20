-- models/secure/secure_customer_view.sql

{{ config(
    materialized='view',
    secure=true
) }}

select CUST_ID, FULL_NAME, PHN_NUMBER, EMAIL
from {{ ref('customer') }}
