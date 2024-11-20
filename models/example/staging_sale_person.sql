{{ config(materialized='view') }}

with raw_data as (
    -- Lấy dữ liệu từ bảng region gốc trong source work2022
    select * 
    from {{ source('work2022', 'sale_person') }}
),

processed_data as (
    SELECT
        emp_key,
        emp_id,
        split_part(sale_person_name, ' ', 1) AS first_name,
        split_part(sale_person_name, ' ', 2) AS last_name,
        title,
        upn
    FROM raw_data
)

-- Chọn kết quả cuối cùng để tạo bảng mới staging_region
select * 
from processed_data