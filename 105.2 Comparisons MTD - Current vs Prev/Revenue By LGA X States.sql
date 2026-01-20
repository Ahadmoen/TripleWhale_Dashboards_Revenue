SELECT
  state,
  lga,
  current_mtd_revenue,
  previous_mtd_revenue,
  (current_mtd_revenue - previous_mtd_revenue) AS variance,
  CASE
    WHEN current_mtd_revenue > previous_mtd_revenue THEN '↑ Growth'
    WHEN current_mtd_revenue < previous_mtd_revenue THEN '↓ Decline'
    ELSE '→ Flat'
  END AS trend
FROM
  (
    SELECT
      COALESCE(ot.customer_from_state_code, 'Unknown') AS state,
      COALESCE(ot.customer_from_city, 'Unknown') AS lga,
      SUM(
        CASE
          WHEN ot.event_date BETWEEN toStartOfMonth (CURRENT_DATE()) AND CURRENT_DATE()  THEN order_revenue
          ELSE 0
        END
      ) AS current_mtd_revenue,
      SUM(
        CASE
          WHEN ot.event_date BETWEEN toStartOfMonth (CURRENT_DATE()) - INTERVAL 1 MONTH AND CURRENT_DATE()  - INTERVAL 1 MONTH THEN order_revenue
          ELSE 0
        END
      ) AS previous_mtd_revenue
    FROM
      orders_table AS ot
    WHERE
      ot.event_date BETWEEN toStartOfMonth (CURRENT_DATE()) - INTERVAL 1 MONTH AND CURRENT_DATE()
    GROUP BY
      state,
      lga
  ) AS lga_revenue
ORDER BY
  current_mtd_revenue DESC