{{ config(materialized='view') }}

with raw_data as (
    -- Lấy dữ liệu từ bảng product gốc trong source work2022
    select * 
    from {{ source('work2022', 'product') }}
),

processed_data as (
    -- Tiền xử lý dữ liệu (ví dụ: lọc các dòng có giá trị null trong cột 'price')
    select
        product_key,
        product,
        CAST(REGEXP_REPLACE(standard_cost, '[\$,]', '', 'g') AS NUMERIC) as standard_cost,
        color,
        subcategory,
        category,
        background_color,
        font_color_format
    from raw_data
    where product is not null -- Lọc bỏ sản phẩm không có tên
)

-- Chọn kết quả cuối cùng để tạo bảng mới staging_product
select * 
from processed_data
