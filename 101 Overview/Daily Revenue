SELECT
  adt.event_date AS event_date,
  SUM(adt.conversion_value) AS revenue
FROM
  ads_table AS adt
WHERE
  adt.event_date BETWEEN '2025-12-21' AND '2026-01-19'
GROUP BY
  adt.event_date
ORDER BY
  adt.event_date DESC
  