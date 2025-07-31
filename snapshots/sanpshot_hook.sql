{% snapshot my_snapshot %}
{{
    config(
        target_database='DBT_LABS',
        target_schema='SILVER_SCH',
        unique_key='ORDER_ID',
        strategy='timestamp',
        updated_at='updated_at',
        pre_hook="{{ log_snapshot_start('my_snapshot') }}",
        post_hook="{{ log_snapshot_end2('my_snapshot', this) }}"
    )
}}

SELECT * FROM {{ source('supply_data', 'SUPPLY_CHAIN_ORDERS') }}

{% endsnapshot %}
