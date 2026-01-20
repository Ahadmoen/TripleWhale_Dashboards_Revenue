WITH
  state_data AS (
    SELECT
      COALESCE(customer_from_state_code, 'Unknown') AS state_code,
      ROUND(SUM(order_revenue), 2) AS total_revenue,
      ROUND(
        SUM(
          CASE
            WHEN is_new_customer = TRUE THEN order_revenue
            ELSE 0
          END
        ),
        2
      ) AS new_revenue,
      ROUND(
        SUM(
          CASE
            WHEN is_new_customer = FALSE THEN order_revenue
            ELSE 0
          END
        ),
        2
      ) AS returning_revenue
    FROM
      orders_table
    WHERE
      event_date BETWEEN '2025-12-21' AND '2026-01-19'
    GROUP BY
      customer_from_state_code
  ),
  with_percentages AS (
    SELECT
      state_code,
      total_revenue,
      CONCAT(
        ROUND(
          100.0 * total_revenue / SUM(total_revenue) OVER (),
          2
        ),
        '%'
      ) AS pct_of_total,
      new_revenue,
      CONCAT(
        ROUND(
          100.0 * new_revenue / nullIf(SUM(new_revenue) OVER (), 0),
          2
        ),
        '%'
      ) AS new_pct_of_total,
      returning_revenue,
      CONCAT(
        ROUND(
          100.0 * returning_revenue / nullIf(SUM(returning_revenue) OVER (), 0),
          2
        ),
        '%'
      ) AS returning_pct_of_total
    FROM
      state_data
  )
SELECT
  0 AS sort_order,
  state_code,
  total_revenue,
  pct_of_total,
  new_revenue,
  new_pct_of_total,
  returning_revenue,
  returning_pct_of_total
FROM
  with_percentages
UNION ALL
SELECT
  1 AS sort_order,
  'TOTAL' AS state_code,
  SUM(total_revenue) AS total_revenue,
  '100%' AS pct_of_total,
  SUM(new_revenue) AS new_revenue,
  '100%' AS new_pct_of_total,
  SUM(returning_revenue) AS returning_revenue,
  '100%' AS returning_pct_of_total
FROM
  with_percentages
ORDER BY
  sort_order ASC,
  total_revenue DESC