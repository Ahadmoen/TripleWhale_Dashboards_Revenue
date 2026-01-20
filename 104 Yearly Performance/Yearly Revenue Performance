SELECT
  SUM(bst.order_revenue) AS Total_Revenue,
  SUM(bst.total_sales) AS Total_Sales,
  SUM(bst.refund_money) AS Total_Refunds,
  (
    SELECT
      SUM(total_refunded_shipping)
    FROM
      refunds_table
    WHERE
      event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND CURRENT_DATE()
  ) AS Total_Refunded_Shipping,
  (
    SELECT
      SUM(total_refunded_tax)
    FROM
      refunds_table
    WHERE
      event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND CURRENT_DATE()
  ) AS Total_Refunded_Tax
FROM
  blended_stats_tvf () AS bst
WHERE
  bst.event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND CURRENT_DATE()