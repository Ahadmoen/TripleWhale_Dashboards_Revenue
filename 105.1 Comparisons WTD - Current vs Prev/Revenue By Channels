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
      WHEN event_date BETWEEN toStartOfWeek (CURRENT_DATE(), 1) AND CURRENT_DATE()  THEN order_revenue
      ELSE 0
    END
  ) AS current_wtd_revenue,
  SUM(
    CASE
      WHEN event_date BETWEEN toStartOfWeek (CURRENT_DATE(), 1) - 7 AND CURRENT_DATE()  - 7 THEN order_revenue
      ELSE 0
    END
  ) AS previous_wtd_revenue
FROM
  pixel_joined_tvf ()
WHERE
  event_date BETWEEN toStartOfWeek (CURRENT_DATE(), 1) - 7 AND CURRENT_DATE()
  AND model = 'Linear All'
  AND attribution_window = 'lifetime'
GROUP BY
  channel
ORDER BY
  current_wtd_revenue DESC