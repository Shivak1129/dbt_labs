-- MODEL: telecom_plans_by_type.sql
-- Purpose: First fetch all Prepaid plans, then Postpaid, and remove duplicates.

{# Get distinct plan types from TELE_PLANS source #}
{%- set plan_types = dbt_utils.get_column_values(
    table=source('tele_telecom_plans', 'TELE_PLANS'),
    column='plan_type'
) -%}

{# Loop through each plan_type and generate a SQL block with UNION ALL #}
{%- for type in plan_types %}
    -- Generating block for plan_type: {{ type }}

    SELECT
        customer_id,
        plan_id,
        plan_type,
        price
    FROM {{ source('tele_telecom_plans', 'TELE_PLANS') }}
    WHERE plan_type = '{{ type }}'

    {% if not loop.last %}
        UNION 
    {% endif %}
{% endfor %}
