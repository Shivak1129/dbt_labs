-- tests/future_registration_dates.sql
SELECT *
FROM {{ ref('customer_analysis') }}
WHERE registered_on > CURRENT_DATE
