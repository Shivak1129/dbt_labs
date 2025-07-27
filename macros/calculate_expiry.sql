{% macro calculate_expiry(activated_on, validity_days) %}
    DATEADD(day, {{ validity_days }}, {{ activated_on }})
{% endmacro %}