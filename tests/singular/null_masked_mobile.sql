-- tests/null_masked_mobile.sql
SELECT customer_id
FROM {{ ref('customer_analysis') }}
WHERE masked_mobile IS NULL OR masked_mobile = ''
