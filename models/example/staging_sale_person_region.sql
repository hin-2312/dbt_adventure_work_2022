{{ config(materialized='view') }}

with raw_data as (
    -- Lấy dữ liệu từ bảng region gốc trong source work2022
    select * 
    from {{ source('work2022', 'sale_person_region') }}
),

processed_data as (
    select
        *
    from raw_data
)

-- Chọn kết quả cuối cùng để tạo bảng mới staging_region
select * 
from processed_data