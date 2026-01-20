SELECT
  formatDateTime (ot.event_date, '%Y-%m') AS month,
  SUM(
    CASE
      WHEN customer_from_state_code = 'NSW' THEN order_revenue
      ELSE 0
    END
  ) AS NSW,
  SUM(
    CASE
      WHEN customer_from_state_code = 'QLD' THEN order_revenue
      ELSE 0
    END
  ) AS QLD,
  SUM(
    CASE
      WHEN customer_from_state_code = 'VIC' THEN order_revenue
      ELSE 0
    END
  ) AS VIC,
  SUM(
    CASE
      WHEN customer_from_state_code = 'WA' THEN order_revenue
      ELSE 0
    END
  ) AS WA,
  SUM(
    CASE
      WHEN customer_from_state_code = 'SA' THEN order_revenue
      ELSE 0
    END
  ) AS SA,
  SUM(
    CASE
      WHEN customer_from_state_code = 'TAS' THEN order_revenue
      ELSE 0
    END
  ) AS TAS,
  SUM(
    CASE
      WHEN customer_from_state_code = 'ACT' THEN order_revenue
      ELSE 0
    END
  ) AS ACT,
  SUM(
    CASE
      WHEN customer_from_state_code = 'NT' THEN order_revenue
      ELSE 0
    END
  ) AS NT,
  SUM(order_revenue) AS total
FROM
  orders_table AS ot
WHERE
  ot.event_date BETWEEN '2025-12-21' AND '2026-01-19'
GROUP BY
  month
ORDER BY
  month ASC