SELECT
  pjt.event_date AS event_date,
  SUM(pjt.new_customer_order_revenue) AS new_customer_revenue,
  SUM(pjt.order_revenue) - SUM(pjt.new_customer_order_revenue) AS returning_customer_revenue
FROM
  pixel_joined_tvf () AS pjt
WHERE
  pjt.event_date BETWEEN '2025-12-21' AND '2026-01-19'
  AND NOT(pjt.channel IN ('google-ads', 'facebook-ads'))
  AND pjt.model = 'Linear All'
  AND pjt.attribution_window = 'lifetime'
GROUP BY
  pjt.event_date
ORDER BY
  pjt.event_date