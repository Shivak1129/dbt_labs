-- Purpose: Add 18% GST to price
{% macro calculate_gst(price_column) %}
    ROUND({{ price_column }} * 1.18, 2)
{% endmacro %}