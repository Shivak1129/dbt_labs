-- models/my_second_dbt_model.sql

{{
    config(
        materialized='view',
        tags=["dbt_only"]
    )
}}

select *
from {{ ref('my_first_dbt_model') }}
where id = 1
