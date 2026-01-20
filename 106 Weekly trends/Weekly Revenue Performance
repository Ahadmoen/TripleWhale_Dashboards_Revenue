SELECT
  concat(
    'Week ',
    toString (toISOWeek (toStartOfWeek (ot.event_date, 1)))
  ) AS week_number,
  formatDateTime (toStartOfWeek (ot.event_date, 1), '%Y-%m-%d') AS week_start,
  formatDateTime (
    toStartOfWeek (ot.event_date, 1) + INTERVAL 6 DAY,
    '%Y-%m-%d'
  ) AS week_end,
  SUM(ot.order_revenue) AS Revenue
FROM
  orders_table AS ot
WHERE
  ot.event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND CURRENT_DATE()
GROUP BY
  toStartOfWeek (ot.event_date, 1)
ORDER BY
  toStartOfWeek (ot.event_date, 1)