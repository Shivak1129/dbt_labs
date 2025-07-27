-- MACRO: is_valid_email
-- Purpose: Check if the email follows standard email format using regex
-- Works in Snowflake using REGEXP_LIKE()

-- REGEXP EXPLANATION:
-- ^                             → Start of the string
-- [A-Za-z0-9._%+-]+             → Match one or more characters that can be:
--                                 uppercase letters (A-Z),
--                                 lowercase letters (a-z),
--                                 digits (0-9),
--                                 dots (.), underscores (_), percent signs (%), plus signs (+), or hyphens (-)
-- @                             → The '@' symbol must appear exactly once
-- [A-Za-z0-9.-]+                → Match one or more domain characters (letters, digits, dot, hyphen)
-- \\.                           → Escaped dot (.) before domain extension (e.g., .com, .in)
-- [A-Za-z]{2,}                  → Match 2 or more letters for domain extension
-- $                             → End of the string

-- Example valid: user.name123+test@gmail.com
-- Example invalid: user@@domain, user@domain, user@domain.c

{% macro is_valid_email(email_column) %}
    REGEXP_LIKE({{ email_column }}, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')
{% endmacro %}
