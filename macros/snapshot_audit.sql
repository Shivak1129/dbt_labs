{% macro log_snapshot_start(snapshot_name) %}
    INSERT INTO SNOWFLAKE_DBT_DATA.SF_SCHEMA.SNAPSHOT_RUN_AUDIT (
        snapshot_name, database_name, schema_name, execution_time_start
    ) VALUES (
        '{{ snapshot_name }}',
        '{{ config.get("target_database", target.database) }}',
        '{{ config.get("target_schema", target.schema) }}',
        CURRENT_TIMESTAMP
    )
{% endmacro %}

{% macro log_snapshot_end(snapshot_name, relation) %}
    UPDATE SNOWFLAKE_DBT_DATA.SF_SCHEMA.SNAPSHOT_RUN_AUDIT
    SET execution_time_end = CURRENT_TIMESTAMP,
        row_count = (SELECT COUNT(*) FROM {{ relation }})
    WHERE snapshot_name = '{{ snapshot_name }}'
      AND execution_time_end IS NULL;
{% endmacro %}
