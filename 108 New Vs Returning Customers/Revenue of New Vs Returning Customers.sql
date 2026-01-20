SELECT
  o.event_date,
  SUM(
    CASE
      WHEN o.is_new_customer = 1 THEN o.order_revenue
      ELSE 0
    END
  ) AS new_customer_revenue,
  SUM(
    CASE
      WHEN o.is_new_customer = 0 THEN o.order_revenue
      ELSE 0
    END
  ) AS returning_customer_revenue
FROM
  orders_table AS o
WHERE
  o.event_date BETWEEN '2025-12-21' AND '2026-01-19'
GROUP BY
  o.event_date
ORDER BY
  o.event_date ASC