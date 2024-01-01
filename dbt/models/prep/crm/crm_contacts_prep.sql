{{ config(materialized='table', schema='prep_contacts', tags=['master_contacts']) }}

select 
    {{ data_quality_name('name') }}                                 as name
    ,email_address                                                  as email_address
    ,phone_number                                                   as phone_number
    ,title                                                          as title
    ,{{ data_quality_company_name('company_name') }}                as company_name
    ,company_domain                                                 as company_domain 
    ,favorite_color                                                 as favorite_color
    ,created_at                                                     as created_at
    ,updated_at                                                     as updated_at
from  {{ ref('crm_contacts_seed') }}