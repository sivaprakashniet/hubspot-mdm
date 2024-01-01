{{ config(materialized='table', schema='dw_contacts', tags=['master_contacts']) }}

-- Manually curated data from CRM and ACME
with crm_acme as (
    select 
        {{ dbt_utils.star(from=ref('crm_contacts_prep'), except=['favorite_color']) }}
    from {{ ref('crm_contacts_prep')}}

    union
    
    select
        {{ dbt_utils.star(from=ref('acme_contacts_prep'), 
            except=['country', 'company_industry', 'company_employees', 'company_revenue']) }}
    from {{ ref('acme_contacts_prep')}}
),

-- Rapid data with higher error rate 
rapid as (
    select 
        * 
    from crm_acme

    union
    
    select
       {{ dbt_utils.star(from=ref('rapid_data_contacts_prep'), 
            except=['ip_address', 'intent_signals', 'do_not_call']) }}
    from {{ ref('rapid_data_contacts_prep') }}  
    where email_address not in ( 
        select email_address from crm_acme
    )
),   

deduped as (
    select 
       *
    from rapid
    qualify row_number() over (partition by email_address order by updated_at desc) = 1
),

-- Consolidate contacts data with all the available columns 
contacts as (
    select 
        coalesce(com.name, crm.name, acme.name, rapid.name)                                          as name
        ,com.email_address
        ,coalesce(com.phone_number, crm.phone_number, acme.phone_number, rapid.phone_number)         as phone_number
        ,coalesce(com.title, crm.title, acme.title, rapid.title)                                     as title
        ,coalesce(com.company_name, crm.company_name, acme.company_name, rapid.company_name)         as company_name
        ,coalesce(com.company_domain, crm.company_domain, acme.company_domain, rapid.company_domain) as company_domain
        ,crm.favorite_color
        ,acme.country
        ,acme.company_industry
        ,acme.company_employees
        ,acme.company_revenue
        ,rapid.ip_address
        ,rapid.intent_signals
        ,rapid.do_not_call
        ,com.created_at
        ,com.updated_at
    from deduped com
    left join {{ ref('crm_contacts_prep') }} crm on com.email_address = crm.email_address 
    left join {{ ref('acme_contacts_prep') }} acme on com.email_address = acme.email_address
    left join {{ ref('rapid_data_contacts_prep') }} rapid on com.email_address = rapid.email_address
)

-- Match on: To remove duplicate from contacts by name and phone_number
    --   1. fuzzy name, fuzzy phone_number
-- select
    -- name
    -- ,email_address
    -- ,phone_number
    -- ,title
    -- ,company_name
    -- ,company_domain
    -- ,created_at
    -- ,updated_at
-- from deduplicated_data
-- match_recognize(
--     order by updated_at desc
--     measure
--         FINAL FIRST(a.name) as final_name,
--         FINAL FIRST(a.email_address) as final_email_address,
--         FINAL FIRST(a.phone_number) as final_phone_number,
--         FINAL FIRST(a.title) as final_title,
--         FINAL FIRST(a.company_name) as final_company_name,
--         FINAL FIRST(a.company_domain) as final_company_domain,
--         FINAL FIRST(a.created_at) as final_created_at,
--         FINAL FIRST(a.updated_at) as final_updated_at
--     one row per match
--     pattern (a b)
--     define
--         similarity_condition as 
--             JAROWINKLER_SIMILARITY(a.name, b.name) >= 0.8 AND
--             JAROWINKLER_SIMILARITY(a.phone_number, b.phone_number) >= 0.8,
--         skip_record as
--             true
-- ) as matching_records
-- where not skip_record;

select
    'mdm-cont-'|| {{ generate_secret(safe_concat(['email_address'])) }}  as contact_id
    ,*
from contacts
    qualify row_number() over (partition by name, phone_number order by favorite_color, company_revenue, ip_address, updated_at desc) = 1
