SELECT
  formatDateTime (toStartOfMonth (event_date), '%Y-%m-%d') AS month_start,
  formatDateTime (toLastDayOfMonth (event_date), '%Y-%m-%d') AS month_end,
  SUM(order_revenue) AS Revenue
FROM
  orders_table
WHERE
  event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND CURRENT_DATE()
  AND toStartOfMonth (event_date) >= toStartOfYear (CURRENT_DATE())
GROUP BY
  month_start,
  month_end
ORDER BY
  month_start