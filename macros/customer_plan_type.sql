-- MACRO: customer_latest_plan()
-- Purpose: Returns latest plan_type per customer
{% macro customer_latest_plan() %}
(
    SELECT *
    FROM {{ source('tele_telecom_plans', 'TELE_PLANS') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY activated_on DESC) = 1
)
{% endmacro %}
