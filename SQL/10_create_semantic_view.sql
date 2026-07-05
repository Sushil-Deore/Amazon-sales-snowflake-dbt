USE DATABASE my_db;
USE SCHEMA analytics;

--DROP SEMANTIC VIEW my_db.analytics.amazon_sales_sv;

CREATE SEMANTIC VIEW my_db.analytics.amazon_sales_sv
  TABLES (
    sales AS mart_amazon_sales
      PRIMARY KEY (order_id)
  )
  DIMENSIONS (
    sales.category AS category,
    sales.ship_state AS ship_state,
    sales.status AS status,
    sales.order_date AS order_date
  )
  METRICS (
    sales.total_amount AS SUM(amount),
    sales.total_qty AS SUM(qty),
    sales.order_count AS COUNT(order_id)
  );