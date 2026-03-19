-- =========================================================
-- 01 DATA CLEANING & BASE TABLE SETUP
-- =========================================================
-- Objective:
-- Build raw table, import data, create sample dataset,
-- and define base analytical views

-- =========================================================
-- 1. DATABASE SETUP
-- =========================================================

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Raw events table
CREATE TABLE ecommerce_events (
    event_time     DATETIME,
    event_type     VARCHAR(20),
    product_id     BIGINT,
    category_id    BIGINT,
    category_code  VARCHAR(120),
    brand          VARCHAR(80),
    price          DECIMAL(10,2),
    user_id        BIGINT,
    user_session   VARCHAR(64)
);

-- =========================================================
-- 2. INDEXING (AFTER IMPORT)
-- =========================================================

ALTER TABLE ecommerce_events
ADD INDEX idx_event_type (event_type),
ADD INDEX idx_user_id (user_id),
ADD INDEX idx_event_time (event_time);

-- =========================================================
-- 3. SAMPLE DATA CREATION (STRATIFIED)
-- =========================================================
-- Why:
-- Full dataset (~100M+) too large for local machine

CREATE TABLE ecommerce_sample AS
WITH
view_sample AS (
    SELECT * FROM ecommerce_events
    WHERE event_type = 'view'
    ORDER BY RAND(42)
    LIMIT 440000
),
cart_sample AS (
    SELECT * FROM ecommerce_events
    WHERE event_type = 'cart'
    ORDER BY RAND(42)
    LIMIT 45000
),
purchase_sample AS (
    SELECT * FROM ecommerce_events
    WHERE event_type = 'purchase'
    ORDER BY RAND(42)
    LIMIT 15000
)
SELECT * FROM view_sample
UNION ALL
SELECT * FROM cart_sample
UNION ALL
SELECT * FROM purchase_sample;

-- =========================================================
-- 4. CLEAN EVENTS VIEW
-- =========================================================
-- Central analytical layer

CREATE OR REPLACE VIEW clean_events AS
SELECT
    event_time,
    DATE(event_time) AS event_date,
    HOUR(event_time) AS event_hour,
    event_type,
    product_id,
    category_code,
    brand,
    price,
    user_id,
    user_session
FROM ecommerce_sample
WHERE price IS NOT NULL
AND event_type IN ('view','cart','purchase');

-- =========================================================
-- 5. SESSION TABLE
-- =========================================================

CREATE OR REPLACE VIEW session_table AS
SELECT
    user_session,
    MIN(event_time) AS session_start,
    MAX(event_time) AS session_end,
    COUNT(*) AS session_events
FROM clean_events
GROUP BY user_session;

-- =========================================================
-- 6. SESSION DURATION
-- =========================================================

CREATE OR REPLACE VIEW session_duration AS
SELECT
    user_session,
    TIMESTAMPDIFF(SECOND, session_start, session_end) AS duration_seconds
FROM session_table;

-- =========================================================
-- 7. PURCHASE TABLE
-- =========================================================

CREATE OR REPLACE VIEW purchase_table AS
SELECT *
FROM clean_events
WHERE event_type='purchase';

-- =========================================================
-- 8. CUSTOMER METRICS
-- =========================================================

CREATE OR REPLACE VIEW customer_metrics AS
SELECT
    user_id,
    COUNT(*) AS total_orders,
    SUM(price) AS total_spend,
    AVG(price) AS avg_order_value
FROM purchase_table
GROUP BY user_id;

-- =========================================================
-- 9. PRODUCT METRICS
-- =========================================================

CREATE OR REPLACE VIEW product_metrics AS
SELECT
    product_id,
    COUNT(*) AS purchase_count,
    SUM(price) AS revenue
FROM purchase_table
GROUP BY product_id;