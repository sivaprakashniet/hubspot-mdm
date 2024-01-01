{{ config(materialized='view', schema='mart', tags=['master_contacts']) }}

select 
    {{ dbt_utils.star(from=ref('master_contacts'), except=[]) }}
from {{ ref('master_contacts')}}
