WITH
  totals AS (
    SELECT
      SUM(all_conversion_value) AS new_customer_revenue,
      SUM(conversion_value) - SUM(all_conversion_value) AS returning_customer_revenue,
      SUM(conversion_value) AS total_revenue
    FROM
      ads_table
    WHERE
      event_date BETWEEN '2025-12-21' AND '2026-01-19'
  )
SELECT
  'new_customer_revenue' AS metric_name,
  new_customer_revenue AS value,
  ROUND(
    new_customer_revenue / nullIf(total_revenue, 0) * 100,
    2
  ) AS contribution_pct
FROM
  totals
UNION ALL
SELECT
  'returning_customer_revenue' AS metric_name,
  returning_customer_revenue AS value,
  ROUND(
    returning_customer_revenue / nullIf(total_revenue, 0) * 100,
    2
  ) AS contribution_pct
FROM
  totals
UNION ALL
SELECT
  'total_revenue' AS metric_name,
  total_revenue AS value,
  100.00 AS contribution_pct
FROM
  totals