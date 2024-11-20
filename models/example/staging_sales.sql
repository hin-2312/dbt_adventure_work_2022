{{ config(materialized='view') }}

with raw_data as (
    -- Lấy dữ liệu từ bảng region gốc trong source work2022
    select * 
    from {{ source('work2022', 'sales') }}
),

processed_data as (
      SELECT 
        sale_order_number,
        order_date,
        product_key,
        reseller_key,
        emp_key,
        sale_territory_key,
        quantity,
        
        -- Chuyển đổi `unit_price` từ text sang numeric
        CAST(REGEXP_REPLACE(unit_price, '[\$,]', '', 'g') AS NUMERIC) AS unit_price,

        -- Chuyển đổi `sales` từ text sang numeric
        CAST(REGEXP_REPLACE(sales, '[\$,]', '', 'g') AS NUMERIC) AS sales,

        -- Chuyển đổi `cost` từ text sang numeric
        CAST(REGEXP_REPLACE(cost, '[\$,]', '', 'g') AS NUMERIC) AS cost
    from raw_data
)

-- Chọn kết quả cuối cùng để tạo bảng mới staging_region
select * 
from processed_data