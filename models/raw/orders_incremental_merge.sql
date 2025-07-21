{{ 
  config(
    materialized = 'incremental',                  
    unique_key = 'order_id',                       
    cluster_by = ['order_date'],                   
    incremental_strategy = 'merge',                
    incremental_predicates = [
      "DBT_INTERNAL_SOURCE.last_updated >= dateadd(day, -7, current_date)"
    ],

    query_tag = 'dbt'                             
  ) 
}}
-- Build model incrementally (only new/changed data processed)
-- # Primary key used for deduplication and merge logic
-- The SQL logic for selecting data from the source (raw data)
-- # Optimize physical layout in warehouse for faster queries
-- # Use MERGE statement for incremental updates

--incremental_predicates
--# This helps Snowflake scan fewer rows in the destination table during merge
--# Only partitions where last_updated in source is in the last 7 days are considered
SELECT
  order_id,
  customer_id,
  order_date,
  order_status,
  amount,
  last_updated
FROM {{ source('order_data', 'orders') }}

-- This WHERE clause limits the incoming (source) data during incremental runs
-- It ensures we only consider new or updated records from the source within the last 7 days
{% if is_incremental() %}
WHERE last_updated >= dateadd(day, -7, current_date)
{% endif %}
