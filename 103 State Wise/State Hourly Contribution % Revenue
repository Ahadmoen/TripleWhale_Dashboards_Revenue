SELECT
  ot.event_date AS event_date,
  ROUND(
    100.0 * SUM(
      CASE
        WHEN ot.customer_from_state_code = 'ACT' THEN ot.order_revenue
        ELSE 0
      END
    ) / SUM(ot.order_revenue),
    2
  ) AS ACT_pct,
  ROUND(
    100.0 * SUM(
      CASE
        WHEN ot.customer_from_state_code = 'NSW' THEN ot.order_revenue
        ELSE 0
      END
    ) / SUM(ot.order_revenue),
    2
  ) AS NSW_pct,
  ROUND(
    100.0 * SUM(
      CASE
        WHEN ot.customer_from_state_code = 'NT' THEN ot.order_revenue
        ELSE 0
      END
    ) / SUM(ot.order_revenue),
    2
  ) AS NT_pct,
  ROUND(
    100.0 * SUM(
      CASE
        WHEN ot.customer_from_state_code = 'QLD' THEN ot.order_revenue
        ELSE 0
      END
    ) / SUM(ot.order_revenue),
    2
  ) AS QLD_pct,
  ROUND(
    100.0 * SUM(
      CASE
        WHEN ot.customer_from_state_code = 'SA' THEN ot.order_revenue
        ELSE 0
      END
    ) / SUM(ot.order_revenue),
    2
  ) AS SA_pct,
  ROUND(
    100.0 * SUM(
      CASE
        WHEN ot.customer_from_state_code = 'TAS' THEN ot.order_revenue
        ELSE 0
      END
    ) / SUM(ot.order_revenue),
    2
  ) AS TAS_pct,
  ROUND(
    100.0 * SUM(
      CASE
        WHEN ot.customer_from_state_code = 'VIC' THEN ot.order_revenue
        ELSE 0
      END
    ) / SUM(ot.order_revenue),
    2
  ) AS VIC_pct,
  ROUND(
    100.0 * SUM(
      CASE
        WHEN ot.customer_from_state_code = 'WA' THEN ot.order_revenue
        ELSE 0
      END
    ) / SUM(ot.order_revenue),
    2
  ) AS WA_pct,
  ROUND(
    100.0 * SUM(
      CASE
        WHEN NOT(
          ot.customer_from_state_code IN (
            'ACT',
            'NSW',
            'NT',
            'QLD',
            'SA',
            'TAS',
            'VIC',
            'WA'
          )
        ) THEN ot.order_revenue
        ELSE 0
      END
    ) / SUM(ot.order_revenue),
    2
  ) AS Other_pct
FROM
  orders_table AS ot
WHERE
  ot.event_date BETWEEN '2025-12-21' AND '2026-01-19'
GROUP BY
  ot.event_date
ORDER BY
  ot.event_date ASC