WITH
  state_customer_revenue AS (
    SELECT
      COALESCE(customer_from_state_code, 'Unknown') AS state_code,
      SUM(
        CASE
          WHEN is_new_customer = TRUE THEN order_revenue
          ELSE 0
        END
      ) AS new_customer_revenue,
      SUM(
        CASE
          WHEN is_new_customer = FALSE THEN order_revenue
          ELSE 0
        END
      ) AS returning_customer_revenue,
      SUM(order_revenue) AS total_revenue
    FROM
      orders_table
    WHERE
      event_date BETWEEN '2025-12-21' AND '2026-01-19'
    GROUP BY
      state_code
  )
SELECT
  state_code,
  ROUND(returning_customer_revenue, 2) AS returning_revenue,
  ROUND(total_revenue, 2) AS total_revenue,
  CONCAT(
    ROUND(
      100.0 * new_customer_revenue / nullIf(total_revenue, 0),
      1
    ),
    '%'
  ) AS new_pct,
  CONCAT(
    ROUND(
      100.0 * returning_customer_revenue / nullIf(total_revenue, 0),
      1
    ),
    '%'
  ) AS returning_pct
FROM
  state_customer_revenue
ORDER BY
  total_revenue DESC