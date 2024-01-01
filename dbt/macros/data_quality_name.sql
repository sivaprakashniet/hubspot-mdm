{% macro data_quality_name(column) -%}
case
    when {{ column }} is not null then
        case
            when trim({{ column }}) = '' then null
            else regexp_replace({{ column }},'[*!@^~?#"]','')
        end
    else {{ column }}
end 
{%- endmacro %}