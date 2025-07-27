{% macro get_fiscal_quarter(date_column) %}
    CASE
        WHEN MONTH({{ date_column }}) BETWEEN 4 AND 6 THEN 'Q1'
        WHEN MONTH({{ date_column }}) BETWEEN 7 AND 9 THEN 'Q2'
        WHEN MONTH({{ date_column }}) BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4'
    END
{% endmacro %}