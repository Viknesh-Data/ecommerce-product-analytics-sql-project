-- =========================================================
-- PRODUCT ANALYSIS
-- =========================================================

-- Top Products
SELECT product_id, SUM(price) AS revenue
FROM purchase_table
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 20;

-- Category Performance
SELECT category_code, SUM(price) AS revenue
FROM purchase_table
GROUP BY category_code
ORDER BY revenue DESC;

-- Product Conversion
WITH product_perf AS (
    SELECT 
        product_id,
        COUNT(CASE WHEN event_type='view' THEN 1 END) AS views,
        COUNT(CASE WHEN event_type='purchase' THEN 1 END) AS purchases
    FROM clean_events
    GROUP BY product_id
)
SELECT *,
       ROUND(purchases/views,4) AS conversion_rate
FROM product_perf
WHERE views > 50;