{% test accepted_values_lowercase(model, columns) %}

SELECT *
FROM {{ model }}
WHERE
    {% for col, vals in columns.items() %}
        (
            {{ col }} != LOWER({{ col }}) -- value is not lowercase
            OR {{ col }} NOT IN (
                {% for val in vals %}
                    '{{ val }}'{% if not loop.last %}, {% endif %}
                {% endfor %}
            )
        )
        {% if not loop.last %} OR {% endif %}
    {% endfor %}

{% endtest %}
