WITH
  state_revenue AS (
    SELECT
      customer_from_state_code AS state_segment,
      SUM(order_revenue) AS revenue
    FROM
      orders_table
    WHERE
      event_date BETWEEN '2025-12-21' AND '2026-01-19'
    GROUP BY
      customer_from_state_code
  ),
  grand_total AS (
    SELECT
      SUM(revenue) AS total
    FROM
      state_revenue
  )
SELECT
  state_segment,
  revenue,
  ROUND(
    1 * revenue / (
      SELECT
        total
      FROM
        grand_total
    ),
    2
  ) AS pct_of_total
FROM
  state_revenue
UNION ALL
SELECT
  'Total' AS state_segment,
  total AS revenue,
  1 AS pct_of_total
FROM
  grand_total
ORDER BY
  CASE
    WHEN state_segment = 'Total' THEN 1
    ELSE 0
  END,
  revenue DESC