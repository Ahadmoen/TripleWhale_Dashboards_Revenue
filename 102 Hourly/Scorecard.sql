SELECT
  Hours_Range,
  bucket_revenue AS Revenue,
  ROUND(bucket_revenue / SUM(bucket_revenue) OVER (), 6) AS contribution_pct
FROM
  (
    SELECT
      CASE
        WHEN toInt8 (ot.event_hour) >= 0
        AND toInt8 (ot.event_hour) < 6 THEN '0-5h'
        WHEN toInt8 (ot.event_hour) >= 6
        AND toInt8 (ot.event_hour) < 12 THEN '6-11h'
        WHEN toInt8 (ot.event_hour) >= 12
        AND toInt8 (ot.event_hour) < 18 THEN '12-17h'
        WHEN toInt8 (ot.event_hour) >= 18
        AND toInt8 (ot.event_hour) < 24 THEN '18-24h'
      END AS Hours_Range,
      SUM(ot.order_revenue) AS bucket_revenue
    FROM
      orders_table AS ot
    WHERE
      ot.event_date BETWEEN '2025-12-21' AND '2026-01-19'
    GROUP BY
      Hours_Range
  ) AS buckets
UNION ALL
SELECT
  'TOTAL' AS Hours_Range,
  SUM(ot.order_revenue) AS bucket_revenue,
  1 AS contribution_pct
FROM
  orders_table AS ot
WHERE
  ot.event_date BETWEEN '2025-12-21' AND '2026-01-19'
ORDER BY
  CASE Hours_Range
    WHEN '0-5h' THEN 1
    WHEN '6-11h' THEN 2
    WHEN '12-17h' THEN 3
    WHEN '18-24h' THEN 4
    WHEN 'TOTAL' THEN 5
  END
  