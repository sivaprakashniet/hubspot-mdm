{% macro data_quality_ip_address(column) -%}
CASE
    WHEN {{ column }} IS NOT NULL THEN
        CASE
            WHEN TRIM({{ column }}) = '' THEN NULL
            WHEN NOT REGEXP_LIKE({{ column }}, '^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$|^(([0-9]{1,3}\.){3}[0-9]{1,3})$') THEN NULL
            ELSE {{ column }}
        END
    ELSE NULL
END
{%- endmacro %}