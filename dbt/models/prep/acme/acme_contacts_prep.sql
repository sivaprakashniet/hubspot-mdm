{{ config(materialized='table', schema='prep_contacts', tags=['master_contacts']) }}

select 
    {{ data_quality_name('name') }}                                 as name
    ,email_address                                                  as email_address
    ,phone_number                                                   as phone_number
    ,title                                                          as title
    ,{{ data_quality_company_name('company_name') }}                as company_name
    ,company_domain                                                 as company_domain 
    ,country                                                        as country
    ,company_industry                                               as company_industry
    ,company_employees                                              as company_employees
    ,company_revenue                                                as company_revenue
    ,created_at                                                     as created_at
    ,updated_at                                                     as updated_at  
from  {{ ref('acme_contacts_seed') }}