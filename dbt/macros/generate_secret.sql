{% macro generate_secret(column_name) -%}

   uuid_string( '{{ var("UUID_DEF") }}', {{ column_name }})

{%- endmacro %}
