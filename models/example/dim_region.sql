{{ config(
    materialized='table'
) }}

SELECT 
    *
FROM 
    {{ ref('staging_region') }}
