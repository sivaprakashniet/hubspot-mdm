{% macro extract_name_from_email(email_address) %}
    SPLIT_PART('{{ email_address }}', '@', 1)
{% endmacro %}