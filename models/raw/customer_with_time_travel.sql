{{ config(
    materialized = 'table',
     transient = false,
    data_retention_time_in_days = 5
) }}

SELECT
    *
FROM DBT_LABS.Raw_schema.customer
