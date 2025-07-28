{% test accepted_values_mixedcase(model, titlecase_cols={}, lowercase_cols={}) %}

SELECT *
FROM {{ model }}
WHERE
    (
        {% for col, vals in titlecase_cols.items() %}
            (
                {{ col }} != INITCAP({{ col }})
                OR {{ col }} NOT IN (
                    {% for val in vals %}
                        '{{ val }}'{% if not loop.last %}, {% endif %}
                    {% endfor %}
                )
            )
            {% if not loop.last or lowercase_cols %} OR {% endif %}
        {% endfor %}

        {% for col, vals in lowercase_cols.items() %}
            (
                {{ col }} != LOWER({{ col }})
                OR LOWER({{ col }}) NOT IN (
                    {% for val in vals %}
                        LOWER('{{ val }}'){% if not loop.last %}, {% endif %}
                    {% endfor %}
                )
            )
            {% if not loop.last %} OR {% endif %}
        {% endfor %}
    )

{% endtest %}
