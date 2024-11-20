{{ config(
    materialized='table'
) }}

SELECT 
    product_key, product, standard_cost, subcategory, category
FROM 
    {{ ref('staging_product') }}
GROUP BY 
    product_key, product, standard_cost, subcategory, category
ORDER BY product_key ASC 