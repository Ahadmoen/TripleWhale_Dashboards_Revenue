SELECT
  month,
  revenue,
  refunds,
  pct_of_total_revenue,
  sort_order,
FROM
  (
    SELECT
      formatDateTime (ot.event_date, '%Y-%m') AS month,
      SUM(ot.order_revenue) AS revenue,
      SUM(ot.refund_money) AS refunds,
      ROUND(
        SUM(ot.order_revenue) / SUM(SUM(ot.order_revenue)) OVER (),
        4
      ) AS pct_of_total_revenue,
      0 AS sort_order
    FROM
      orders_table AS ot
    WHERE
      ot.event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND current_date()
    GROUP BY
      month
    UNION ALL
    SELECT
      'TOTAL' AS month,
      SUM(ot.order_revenue) AS revenue,
      SUM(ot.refund_money) AS refunds,
      1 AS pct_of_total_revenue,
      1 AS sort_order
    FROM
      orders_table AS ot
    WHERE
      ot.event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND current_date()
  )
ORDER BY
  sort_order ASC,
  month DESC