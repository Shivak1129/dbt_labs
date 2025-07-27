{% macro age_category(age_column) %}
    CASE
        WHEN {{ age_column }} < 30 THEN 'Young'
        WHEN {{ age_column }} BETWEEN 30 AND 45 THEN 'Mid'
        ELSE 'Senior'
    END
{% endmacro %}