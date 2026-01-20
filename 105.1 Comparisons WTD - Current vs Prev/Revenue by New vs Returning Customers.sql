SELECT
  'Current WTD' AS period,
  SUM(
    CASE
      WHEN is_new_customer = true THEN order_revenue
      ELSE 0
    END
  ) AS new_customer_revenue,
  SUM(
    CASE
      WHEN is_new_customer = false THEN order_revenue
      ELSE 0
    END
  ) AS returning_customer_revenue
FROM
  orders_table
WHERE
  event_date BETWEEN toStartOfWeek (CURRENT_DATE(), 1) AND CURRENT_DATE()  - 1
UNION ALL
SELECT
  'Previous WTD' AS period,
  SUM(
    CASE
      WHEN is_new_customer = true THEN order_revenue
      ELSE 0
    END
  ) AS new_customer_revenue,
  SUM(
    CASE
      WHEN is_new_customer = false THEN order_revenue
      ELSE 0
    END
  ) AS returning_customer_revenue
FROM
  orders_table
WHERE
  event_date BETWEEN toStartOfWeek (CURRENT_DATE(), 1) - 7 AND CURRENT_DATE()  - 1 - 7
ORDER BY
  period DESC