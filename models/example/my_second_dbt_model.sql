-- models/my_second_dbt_model.sql

{{
    config(
        materialized='table',
        transient=false,
        tags=["dbt_only"]
    )
}}

select *
from {{ ref('my_first_dbt_model') }}
where id = 1
