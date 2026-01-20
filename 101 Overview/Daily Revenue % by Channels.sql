SELECT
  toString (pot.event_date) AS event_date,
  ROUND(
    100.0 * sumIf (pot.order_revenue, pot.channel = 'google-ads') / SUM(pot.order_revenue),
    2
  ) AS google_ads_pct,
  ROUND(
    100.0 * sumIf (pot.order_revenue, pot.channel = 'facebook-ads') / SUM(pot.order_revenue),
    2
  ) AS facebook_ads_pct,
  ROUND(
    100.0 * sumIf (pot.order_revenue, pot.channel = 'tiktok-ads') / SUM(pot.order_revenue),
    2
  ) AS tiktok_ads_pct,
  ROUND(
    100.0 * sumIf (pot.order_revenue, pot.channel = 'Direct') / SUM(pot.order_revenue),
    2
  ) AS direct_pct,
  ROUND(
    100.0 * sumIf (
      pot.order_revenue,
      pot.channel = 'organic_and_social'
    ) / SUM(pot.order_revenue),
    2
  ) AS organic_pct,
  ROUND(
    100.0 * sumIf (
      pot.order_revenue,
      lower(pot.utm_source) = 'klaviyo'
      AND lower(pot.utm_medium) = 'email'
    ) / SUM(pot.order_revenue),
    2
  ) AS edm_campaigns_pct,
  ROUND(
    100.0 * sumIf (
      pot.order_revenue,
      lower(pot.utm_source) = 'klaviyo'
      AND lower(pot.utm_medium) = 'flow'
    ) / SUM(pot.order_revenue),
    2
  ) AS edm_flows_pct,
  ROUND(
    100.0 * sumIf (
      pot.order_revenue,
      NOT(
        pot.channel IN (
          'google-ads',
          'facebook-ads',
          'tiktok-ads',
          'Direct',
          'organic_and_social'
        )
      )
      AND NOT(lower(pot.utm_source) = 'klaviyo')
    ) / SUM(pot.order_revenue),
    2
  ) AS other_pct
FROM
  pixel_orders_table AS pot
WHERE
  pot.model = 'Linear All'
  AND pot.attribution_window = 'lifetime'
  AND pot.event_date BETWEEN '2025-12-21' AND '2026-01-19'
GROUP BY
  pot.event_date
UNION ALL
SELECT
  'AVERAGE' AS event_date,
  ROUND(AVG(google_ads_pct), 2) AS google_ads_pct,
  ROUND(AVG(facebook_ads_pct), 2) AS facebook_ads_pct,
  ROUND(AVG(tiktok_ads_pct), 2) AS tiktok_ads_pct,
  ROUND(AVG(direct_pct), 2) AS direct_pct,
  ROUND(AVG(organic_pct), 2) AS organic_pct,
  ROUND(AVG(edm_campaigns_pct), 2) AS edm_campaigns_pct,
  ROUND(AVG(edm_flows_pct), 2) AS edm_flows_pct,
  ROUND(AVG(other_pct), 2) AS other_pct
FROM
  (
    SELECT
      toString (pot.event_date) AS event_date,
      100.0 * sumIf (pot.order_revenue, pot.channel = 'google-ads') / SUM(pot.order_revenue) AS google_ads_pct,
      100.0 * sumIf (pot.order_revenue, pot.channel = 'facebook-ads') / SUM(pot.order_revenue) AS facebook_ads_pct,
      100.0 * sumIf (pot.order_revenue, pot.channel = 'tiktok-ads') / SUM(pot.order_revenue) AS tiktok_ads_pct,
      100.0 * sumIf (pot.order_revenue, pot.channel = 'Direct') / SUM(pot.order_revenue) AS direct_pct,
      100.0 * sumIf (
        pot.order_revenue,
        pot.channel = 'organic_and_social'
      ) / SUM(pot.order_revenue) AS organic_pct,
      100.0 * sumIf (
        pot.order_revenue,
        lower(pot.utm_source) = 'klaviyo'
        AND lower(pot.utm_medium) = 'email'
      ) / SUM(pot.order_revenue) AS edm_campaigns_pct,
      100.0 * sumIf (
        pot.order_revenue,
        lower(pot.utm_source) = 'klaviyo'
        AND lower(pot.utm_medium) = 'flow'
      ) / SUM(pot.order_revenue) AS edm_flows_pct,
      100.0 * sumIf (
        pot.order_revenue,
        NOT(
          pot.channel IN (
            'google-ads',
            'facebook-ads',
            'tiktok-ads',
            'Direct',
            'organic_and_social'
          )
        )
        AND NOT(lower(pot.utm_source) = 'klaviyo')
      ) / SUM(pot.order_revenue) AS other_pct
    FROM
      pixel_orders_table AS pot
    WHERE
      pot.model = 'Linear All'
      AND pot.attribution_window = 'lifetime'
      AND pot.event_date BETWEEN '2025-12-21' AND '2026-01-19'
    GROUP BY
      pot.event_date
  ) AS daily_pct
ORDER BY
  event_date ASC