{{ config(materialized='table', schema='master_contacts', tags=['master_contacts']) }}

select 
    {{ dbt_utils.star(from=ref('dw_contacts'), except=[]) }}
from {{ ref('dw_contacts')}}
