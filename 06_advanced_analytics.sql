-- =========================================================
-- ADVANCED ANALYTICS
-- =========================================================

-- Revenue Trend
SELECT 
    event_date,
    SUM(price) AS revenue,
    SUM(SUM(price)) OVER (ORDER BY event_date) AS cumulative_revenue
FROM purchase_table
GROUP BY event_date;

-- Cohort Analysis
CREATE OR REPLACE VIEW user_cohort AS
SELECT 
    user_id,
    MIN(DATE(event_time)) AS cohort_date
FROM purchase_table
GROUP BY user_id;

-- Cohort Retention
SELECT 
    cohort_date,
    COUNT(DISTINCT user_id) AS users
FROM user_cohort
GROUP BY cohort_date;

-- Pareto Analysis
WITH customer_spend AS (
    SELECT user_id, SUM(price) AS spend
    FROM purchase_table
    GROUP BY user_id
)
SELECT *,
       NTILE(10) OVER (ORDER BY spend DESC) AS decile
FROM customer_spend;

-- A/B Testing Simulation
CREATE OR REPLACE VIEW ab_groups AS
SELECT 
    user_id,
    CASE WHEN MOD(user_id,2)=0 THEN 'A' ELSE 'B' END AS group_type
FROM clean_events
GROUP BY user_id;

SELECT 
    group_type,
    COUNT(*) AS users
FROM ab_groups
GROUP BY group_type;