-- Fails if gender is not 'Male' or 'Female' with exact casing
SELECT *
FROM {{ ref('customer_analysis') }}
WHERE gender NOT IN ('Male', 'Female')
