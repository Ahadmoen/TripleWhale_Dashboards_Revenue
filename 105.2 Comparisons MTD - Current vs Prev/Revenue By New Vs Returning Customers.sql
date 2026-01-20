SELECT
  'Current MTD' AS period,
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
  event_date BETWEEN toStartOfMonth (CURRENT_DATE()) AND CURRENT_DATE()  - 1
UNION ALL
SELECT
  'Previous MTD' AS period,
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
  event_date BETWEEN toStartOfMonth (CURRENT_DATE()) - INTERVAL 1 MONTH AND CURRENT_DATE()  - 1 - INTERVAL 1 MONTH
ORDER BY
  period DESC