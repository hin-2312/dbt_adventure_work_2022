{{ config(
    materialized='table'
) }}

SELECT 
    reseller_key, business_type, reseller
FROM 
    {{ ref('staging_reseller') }} 
