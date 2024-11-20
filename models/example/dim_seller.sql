{{ config(
    materialized='table'
) }}

SELECT 
    emp_key, emp_id, first_name, last_name, title
FROM 
    {{ ref('staging_sale_person') }}
GROUP BY 
    emp_key, emp_id, first_name, last_name, title
ORDER BY emp_key ASC 