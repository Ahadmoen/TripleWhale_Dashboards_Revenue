SELECT
  period_label,
  period_start,
  period_end,
  total_conversion_value AS Revenue,
  ROUND(
    total_conversion_value * 100.0 / (
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
      CASE
        WHEN toISOWeek (toStartOfWeek (ot.event_date, 1)) BETWEEN 1 AND LEAST(13, toISOWeek (CURRENT_DATE()))  THEN concat(
          'Weeks 1-',
          toString (LEAST(13, toISOWeek (CURRENT_DATE())))
        )
        WHEN toISOWeek (toStartOfWeek (ot.event_date, 1)) BETWEEN 14 AND LEAST(26, toISOWeek (CURRENT_DATE()))  THEN concat(
          'Weeks 14-',
          toString (LEAST(26, toISOWeek (CURRENT_DATE())))
        )
        WHEN toISOWeek (toStartOfWeek (ot.event_date, 1)) BETWEEN 27 AND LEAST(39, toISOWeek (CURRENT_DATE()))  THEN concat(
          'Weeks 27-',
          toString (LEAST(39, toISOWeek (CURRENT_DATE())))
        )
        WHEN toISOWeek (toStartOfWeek (ot.event_date, 1)) BETWEEN 40 AND toISOWeek  (CURRENT_DATE()) THEN concat(
          'Weeks 40-',
          toString (toISOWeek (CURRENT_DATE()))
        )
      END AS period_label,
      formatDateTime (MIN(toStartOfWeek (ot.event_date, 1)), '%Y-%m-%d') AS period_start,
      formatDateTime (
        MAX(toStartOfWeek (ot.event_date, 1) + INTERVAL 6 DAY),
        '%Y-%m-%d'
      ) AS period_end,
      SUM(ot.order_revenue) AS total_conversion_value,
      1 AS sort_order
    FROM
      orders_table AS ot
    WHERE
      ot.event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND CURRENT_DATE()
    GROUP BY
      period_label
    HAVING
      period_label IS NOT NULL
    UNION ALL
    SELECT
      'Total YTD' AS period_label,
      formatDateTime (toStartOfYear (CURRENT_DATE()), '%Y-%m-%d') AS period_start,
      formatDateTime (CURRENT_DATE(), '%Y-%m-%d') AS period_end,
      SUM(ot.order_revenue) AS total_conversion_value,
      2 AS sort_order
    FROM
      orders_table AS ot
    WHERE
      ot.event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND CURRENT_DATE()
  )
ORDER BY
  sort_order,
  period_label