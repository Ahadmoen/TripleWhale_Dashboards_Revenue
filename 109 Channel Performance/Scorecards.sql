SELECT
  pjt.channel AS channel,
  SUM(pjt.order_revenue) AS revenue,
  ROUND(
    SUM(pjt.order_revenue) / SUM(SUM(pjt.order_revenue)) OVER () * 100,
    2
  ) AS contribution_pct
FROM
  pixel_joined_tvf () AS pjt
WHERE
  pjt.event_date BETWEEN '2025-12-21' AND '2026-01-19'
  AND pjt.model = 'Linear All'
  AND pjt.attribution_window = 'lifetime'
GROUP BY
  pjt.channel
ORDER BY
  revenue DESC