{% macro standardize_state(state_column) %}
    INITCAP({{ state_column }})
{% endmacro %}