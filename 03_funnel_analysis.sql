-- =========================================================
-- FUNNEL ANALYSIS
-- =========================================================

-- Overall Funnel
SELECT
    SUM(event_type='view') AS views,
    SUM(event_type='cart') AS carts,
    SUM(event_type='purchase') AS purchases
FROM clean_events;

-- Conversion Rates
SELECT
    ROUND(SUM(event_type='cart')/SUM(event_type='view')*100,2) AS view_to_cart,
    ROUND(SUM(event_type='purchase')/SUM(event_type='cart')*100,2) AS cart_to_purchase
FROM clean_events;

-- High Intent Abandon Users
WITH abandoners AS (
    SELECT user_id,
           SUM(event_type='cart') AS carts,
           SUM(event_type='purchase') AS purchases
    FROM clean_events
    GROUP BY user_id
)
SELECT *
FROM abandoners
WHERE carts > 0 AND purchases = 0
ORDER BY carts DESC;