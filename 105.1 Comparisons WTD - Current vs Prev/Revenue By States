SELECT
  state,
  current_wtd_revenue,
  previous_wtd_revenue,
  (current_wtd_revenue - previous_wtd_revenue) AS variance,
  CASE
    WHEN current_wtd_revenue > previous_wtd_revenue THEN '↑ Growth'
    WHEN current_wtd_revenue < previous_wtd_revenue THEN '↓ Decline'
    ELSE '→ Flat'
  END AS trend
FROM
  (
    SELECT
      COALESCE(ot.customer_from_state_code, 'Unknown') AS state,
      SUM(
        CASE
          WHEN ot.event_date BETWEEN toStartOfWeek (CURRENT_DATE(), 1) AND CURRENT_DATE()  THEN order_revenue
          ELSE 0
        END
      ) AS current_wtd_revenue,
      SUM(
        CASE
          WHEN ot.event_date BETWEEN toStartOfWeek (CURRENT_DATE(), 1) - 7 AND CURRENT_DATE()  - 7 THEN order_revenue
          ELSE 0
        END
      ) AS previous_wtd_revenue
    FROM
      orders_table AS ot
    WHERE
      ot.event_date BETWEEN toStartOfWeek (CURRENT_DATE(), 1) - 7 AND CURRENT_DATE()
    GROUP BY
      state
  ) AS state_revenue
ORDER BY
  current_wtd_revenue DESC