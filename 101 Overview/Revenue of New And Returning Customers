SELECT
  bst.event_date AS event_date,
  SUM(bst.new_customer_revenue) AS new_customer_revenue,
  SUM(bst.order_revenue - bst.new_customer_revenue) AS returning_customer_revenue
FROM
  blended_stats_tvf () AS bst
WHERE
  bst.event_date BETWEEN '2025-12-21' AND '2026-01-19'
GROUP BY
  bst.event_date
ORDER BY
  bst.event_date DESC