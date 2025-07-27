{% macro is_plan_active(active_column) %}
    CASE WHEN {{ active_column }} THEN 'Active' ELSE 'Inactive' END
{% endmacro %}