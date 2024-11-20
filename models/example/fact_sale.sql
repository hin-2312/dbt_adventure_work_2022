{{ config(
    materialized='table'
) }}

SELECT 
    s.sale_order_number,
    s.order_date,
    p.product_key,
    r.reseller_key,
    e.emp_key,
    t.sale_territory_key,
    s.quantity,
    s.unit_price,
    s.sales,
    s.cost
FROM 
    {{ ref('staging_sales') }} s
LEFT JOIN 
    {{ ref('dim_product') }} p
ON 
    s.product_key = p.product_key
LEFT JOIN 
    {{ ref('dim_seller') }} e
ON 
    s.emp_key = e.emp_key
LEFT JOIN 
    {{ ref('dim_region') }} t
ON 
    s.sale_territory_key = t.sale_territory_key
LEFT JOIN 
    {{ ref('dim_reseller') }} r
ON 
    s.reseller_key=r.reseller_key