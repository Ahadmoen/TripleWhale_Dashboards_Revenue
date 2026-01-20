SELECT
  pjt.event_date AS event_date,
  sumIf (pjt.order_revenue, pjt.channel = 'google-ads') AS google_ads_revenue,
  sumIf (pjt.order_revenue, pjt.channel = 'facebook-ads') AS facebook_ads_revenue,
  sumIf (pjt.order_revenue, pjt.channel = 'tiktok-ads') AS tiktok_ads_revenue,
  sumIf (pjt.order_revenue, pjt.channel = 'amazon') AS amazon_revenue,
  sumIf (pjt.order_revenue, pjt.channel = 'Direct') AS direct_revenue,
  sumIf (
    pjt.order_revenue,
    pjt.channel = 'organic_and_social'
  ) AS organic_revenue,
  sumIf (pjt.order_revenue, pjt.channel = 'klaviyo') AS edm_revenue,
  sumIf (
    pjt.order_revenue,
    NOT(
      pjt.channel IN (
        'google-ads',
        'facebook-ads',
        'tiktok-ads',
        'snapchat-ads',
        'pinterest-ads',
        'taboola',
        'amazon',
        'Direct',
        'organic_and_social',
        'klaviyo'
      )
    )
  ) AS other_channels_revenue
FROM
  pixel_joined_table AS pjt
WHERE
  pjt.model = 'Triple Attribution'
  AND pjt.attribution_window = 'lifetime'
  AND pjt.event_date BETWEEN '2025-12-21' AND '2026-01-19'
GROUP BY
  pjt.event_date
ORDER BY
  pjt.event_date ASC