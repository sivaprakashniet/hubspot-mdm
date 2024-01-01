{{ config(materialized='table', schema='prep_contacts', tags=['master_contacts']) }}

select
    {{ data_quality_name('name') }}                                     as name
    ,email_address                                                      as email_address
    ,phone_number                                                       as phone_number
    ,title                                                              as title
    ,{{ data_quality_company_name('company_name') }}                    as company_name
    ,company_domain                                                     as company_domain 
    ,{{ data_quality_ip_address('ip_address') }}                        as ip_address
    ,parse_json(intent_signals)                                         as intent_signals
    ,do_not_call                                                        as do_not_call
    ,created_at                                                         as created_at
    ,updated_at                                                         as updated_at  
from  {{ ref('rapid_data_contacts_seed') }}