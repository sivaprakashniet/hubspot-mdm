{% macro data_quality_company_name(column_name) -%}
case
    when {{ column_name }} is not null then
        case
            when trim({{ column_name }}) = '' then null
            else regexp_replace({{ column_name }},'[*!@^~?#"]','')
        end
    else {{ column_name }}
end 
{%- endmacro %}