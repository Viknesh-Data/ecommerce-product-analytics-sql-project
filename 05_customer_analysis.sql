-- =========================================================
-- CUSTOMER ANALYSIS
-- =========================================================

-- Customer Lifetime Value
SELECT 
    user_id,
    SUM(price) AS lifetime_value,
    COUNT(*) AS total_orders
FROM purchase_table
GROUP BY user_id
ORDER BY lifetime_value DESC;

-- RFM Segmentation
WITH rfm AS (
    SELECT 
        user_id,
        MAX(event_time) AS last_purchase,
        COUNT(*) AS frequency,
        SUM(price) AS monetary
    FROM purchase_table
    GROUP BY user_id
)
SELECT *,
       NTILE(4) OVER (ORDER BY monetary DESC) AS m_score,
       NTILE(4) OVER (ORDER BY frequency DESC) AS f_score
FROM rfm;

-- Top Customers
CREATE OR REPLACE VIEW top_customers AS
SELECT 
    user_id,
    SUM(price) AS total_spent,
    COUNT(*) AS orders
FROM purchase_table
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 100;