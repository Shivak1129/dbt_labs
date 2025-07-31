{% macro log_snapshot_end2(snapshot_name, relation_name) %}
    {% set rel = snapshot(relation_name) %}

    update SNOWFLAKE_DBT_DATA.SF_SCHEMA.SNAPSHOT_RUN_AUDIT
    set
        execution_time_end = current_timestamp,
        row_count = (select count(*) from {{ rel }}),
        rows_inserted = (
            select count(*) from {{ rel }}
            where dbt_valid_from = dbt_valid_to
        ),
        rows_updated = (
            select count(*) from {{ rel }}
            where dbt_valid_to != dbt_valid_from
        )
    where
        snapshot_name = '{{ snapshot_name }}'
        and execution_time_end is null;

{% endmacro %}
