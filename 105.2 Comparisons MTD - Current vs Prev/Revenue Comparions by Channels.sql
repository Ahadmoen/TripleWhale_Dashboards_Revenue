SELECT
  CASE
    WHEN channel = 'google-ads' THEN 'google_ads'
    WHEN channel = 'facebook-ads' THEN 'fb_ads'
    WHEN channel = 'organic_and_social' THEN 'organic'
    WHEN channel = 'Direct' THEN 'direct'
    WHEN channel = 'criteo' THEN 'criteo'
    WHEN channel = 'klaviyo'
    AND campaign_name LIKE '%campaign%' THEN 'edm_campaign'
    WHEN channel = 'klaviyo'
    AND NOT campaign_name LIKE '%campaign%' THEN 'edm_flow'
    ELSE 'others'
  END AS channel,
  SUM(
    CASE
      WHEN event_date BETWEEN toStartOfMonth (CURRENT_DATE()) AND CURRENT_DATE()  THEN order_revenue
      ELSE 0
    END
  ) AS current_mtd_revenue,
  SUM(
    CASE
      WHEN event_date BETWEEN toStartOfMonth (CURRENT_DATE() - INTERVAL 1 MONTH) AND CURRENT_DATE()  - INTERVAL 1 MONTH THEN order_revenue
      ELSE 0
    END
  ) AS previous_mtd_revenue
FROM
  pixel_joined_tvf ()
WHERE
  event_date BETWEEN toStartOfMonth (CURRENT_DATE() - INTERVAL 1 MONTH) AND CURRENT_DATE()
  AND model = 'Linear All'
  AND attribution_window = 'lifetime'
GROUP BY
  channel
ORDER BY
  current_mtd_revenue DESC