SELECT
  formatDateTime (toStartOfMonth (event_date), '%Y-%m-%d') AS month_start,
  formatDateTime (toLastDayOfMonth (event_date), '%Y-%m-%d') AS month_end,
  SUM(
    CASE
      WHEN channel = 'google-ads' THEN order_revenue
      ELSE 0
    END
  ) AS google_ads,
  SUM(
    CASE
      WHEN channel = 'facebook-ads' THEN order_revenue
      ELSE 0
    END
  ) AS fb_ads,
  SUM(
    CASE
      WHEN channel = 'organic_and_social' THEN order_revenue
      ELSE 0
    END
  ) AS organic,
  SUM(
    CASE
      WHEN channel = 'Direct' THEN order_revenue
      ELSE 0
    END
  ) AS direct,
  SUM(
    CASE
      WHEN channel = 'criteo' THEN order_revenue
      ELSE 0
    END
  ) AS criteo,
  SUM(
    CASE
      WHEN channel = 'klaviyo'
      AND campaign_name LIKE '%campaign%' THEN order_revenue
      ELSE 0
    END
  ) AS edm_campaign,
  SUM(
    CASE
      WHEN channel = 'klaviyo'
      AND NOT campaign_name LIKE '%campaign%' THEN order_revenue
      ELSE 0
    END
  ) AS edm_flow,
  SUM(
    CASE
      WHEN NOT(
        channel IN (
          'google-ads',
          'facebook-ads',
          'organic_and_social',
          'Direct',
          'criteo',
          'klaviyo'
        )
      ) THEN order_revenue
      ELSE 0
    END
  ) AS others,
  SUM(order_revenue) AS total
FROM
  pixel_joined_tvf ()
WHERE
  event_date BETWEEN toStartOfYear (CURRENT_DATE()) AND CURRENT_DATE()
  AND toStartOfMonth (event_date) >= toStartOfYear (CURRENT_DATE())
  AND model = 'Triple Attribution'
  AND attribution_window = 'lifetime'
GROUP BY
  month_start,
  month_end
ORDER BY
  month_start