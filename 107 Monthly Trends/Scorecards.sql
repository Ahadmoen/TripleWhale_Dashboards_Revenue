SELECT
  month_label,
  Revenue,
  ROUND(
    Revenue / (
      SELECT
        SUM(ot.order_revenue)
      FROM
        orders_table AS ot
      WHERE
        ot.event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND CURRENT_DATE()
    ),
    2
  ) AS contribution_to_total
FROM
  (
    SELECT
      formatDateTime (toStartOfMonth (ot.event_date), '%b %Y') AS month_label,
      SUM(ot.order_revenue) AS Revenue,
      0 AS sort_order,
      toStartOfMonth (ot.event_date) AS month_sort
    FROM
      orders_table AS ot
    WHERE
      ot.event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND CURRENT_DATE()
    GROUP BY
      toStartOfMonth (ot.event_date)
    UNION ALL
    SELECT
      'Total' AS month_label,
      SUM(ot.order_revenue) AS Revenue,
      1 AS sort_order,
      toDate ('9999-12-31') AS month_sort
    FROM
      orders_table AS ot
    WHERE
      ot.event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND CURRENT_DATE()
  )
ORDER BY
  sort_order,
  month_sort
  