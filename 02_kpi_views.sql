-- =========================================================
-- KPI LAYER (EXECUTIVE METRICS)
-- =========================================================

-- Core KPI View
CREATE OR REPLACE VIEW kpi_core AS
SELECT 
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(*) AS total_events,
    COUNT(CASE WHEN event_type='purchase' THEN 1 END) AS total_orders,
    SUM(CASE WHEN event_type='purchase' THEN price ELSE 0 END) AS total_revenue,
    ROUND(SUM(price)/COUNT(DISTINCT user_id),2) AS revenue_per_user,
    ROUND(SUM(price)/COUNT(CASE WHEN event_type='purchase' THEN 1 END),2) AS avg_order_value
FROM clean_events;

-- Funnel KPI View
CREATE OR REPLACE VIEW kpi_funnel AS
WITH funnel AS (
    SELECT 
        user_session,
        MAX(event_type='view') AS viewed,
        MAX(event_type='cart') AS carted,
        MAX(event_type='purchase') AS purchased
    FROM clean_events
    GROUP BY user_session
)
SELECT 
    COUNT(*) AS sessions,
    SUM(viewed) AS views,
    SUM(carted) AS carts,
    SUM(purchased) AS purchases,
    ROUND(SUM(carted)/SUM(viewed)*100,2) AS view_to_cart,
    ROUND(SUM(purchased)/SUM(carted)*100,2) AS cart_to_purchase,
    ROUND(SUM(purchased)/SUM(viewed)*100,2) AS conversion_rate
FROM funnel;