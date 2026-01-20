SELECT
  ot.event_hour,
  COALESCE(SUM(ot.order_revenue), 0) AS revenue,
  COALESCE(SUM(ot.order_revenue), 0) AS revenue_sum,
  ROUND(
    100.0 * SUM(ot.order_revenue) / nullIf(SUM(SUM(ot.order_revenue)) OVER (), 0),
    2
  ) AS revenue_pct,
  ROUND(
    100.0 * SUM(SUM(ot.order_revenue)) OVER (
      ORDER BY
        ot.event_hour
    ) / nullIf(SUM(SUM(ot.order_revenue)) OVER (), 0),
    2
  ) AS cumulative_pct
FROM
  orders_table AS ot
WHERE
  ot.event_date BETWEEN '2025-12-21' AND '2026-01-19'
GROUP BY
  ot.event_hour
ORDER BY
  ot.event_hour