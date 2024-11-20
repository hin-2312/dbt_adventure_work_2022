{{ config(materialized='view') }}

with raw_data as (
    -- Lấy dữ liệu từ bảng region gốc trong source work2022
    select * 
    from {{ source('work2022', 'target') }}
),

processed_data as (
    select
        emp_id,
        target_month,
        CAST(REGEXP_REPLACE(target, '[\$,]', '', 'g') AS NUMERIC) AS emp_target
    from raw_data
)

-- Chọn kết quả cuối cùng để tạo bảng mới staging_region
select * 
from processed_data