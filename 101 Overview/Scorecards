SELECT
  SUM(bst.order_revenue) AS total_revenue,
  SUM(bst.new_customer_revenue) AS new_customer_revenue,
  SUM(bst.order_revenue) - SUM(bst.new_customer_revenue) AS returning_customer_revenue,
  ref.total_refunds,
  ref.new_customer_refunds,
  ref.returning_customer_refunds,
  SUM(bst.total_sales) AS total_sales,
  SUM(bst.order_revenue) - ref.total_refunds AS net_revenue,
  SUM(bst.new_customer_revenue) - ref.new_customer_refunds AS net_new_customer_revenue,
  (
    SUM(bst.order_revenue) - SUM(bst.new_customer_revenue)
  ) - ref.returning_customer_refunds AS net_returning_customer_revenue
FROM
  blended_stats_tvf (
    start_date := '2026-01-01',
    end_date := '2026-01-13'
  ) AS bst
  CROSS JOIN (
    SELECT
      SUM(ABS(r.total_refunded_price)) AS total_refunds,
      SUM(
        CASE
          WHEN o.is_new_customer = 1 THEN ABS(r.total_refunded_price)
          ELSE 0
        END
      ) AS new_customer_refunds,
      SUM(
        CASE
          WHEN o.is_new_customer = 0
          OR o.is_new_customer IS NULL THEN ABS(r.total_refunded_price)
          ELSE 0
        END
      ) AS returning_customer_refunds
    FROM
      refunds_table AS r
      LEFT JOIN orders_table AS o ON r.order_id = o.order_id
    WHERE
      r.event_date BETWEEN '2025-12-21' AND '2026-01-19'
  ) AS ref
GROUP BY
  ref.total_refunds,
  ref.new_customer_refunds,
  ref.returning_customer_refunds