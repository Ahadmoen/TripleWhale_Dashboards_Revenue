SELECT
  event_date,
  day_name,
  month_name,
  revenue,
  pct_of_total
FROM
  (
    SELECT
      toString (ot.event_date) AS event_date,
      dateName ('weekday', ot.event_date) AS day_name,
      dateName ('month', ot.event_date) AS month_name,
      COALESCE(SUM(ot.order_revenue), 0) AS revenue,
      ROUND(
        SUM(ot.order_revenue) / SUM(SUM(ot.order_revenue)) OVER (),
        6
      ) AS pct_of_total,
      0 AS sort_order
    FROM
      orders_table AS ot
    WHERE
      ot.event_date BETWEEN toStartOfYear (current_date()) AND current_date()
    GROUP BY
      ot.event_date
    UNION ALL
    SELECT
      'TOTAL' AS event_date,
      '' AS day_name,
      '' AS month_name,
      SUM(ot.order_revenue) AS revenue,
      1 AS pct_of_total,
      1 AS sort_order
    FROM
      orders_table AS ot
    WHERE
      ot.event_date BETWEEN toStartOfYear (current_date()) AND current_date()
  )
ORDER BY
  sort_order ASC,
  event_date DESC