SELECT
    hits.hitNumber,
    hits.type,
    hits.page.pagePath,
    hits.eCommerceAction.action_type,
    CASE hits.eCommerceAction.action_type
        WHEN '1' THEN 'Click product list'
        WHEN '2' THEN 'View product detail'
        WHEN '3' THEN 'Add to cart'
        WHEN '4' THEN 'Remove from cart'
        WHEN '5' THEN 'Begin checkout'
        WHEN '6' THEN 'Complete checkout step'
        WHEN '7' THEN 'Purchase'
        ELSE 'Other'
    END AS action_label,
    hits.transaction.transactionId,
    hits.transaction.transactionRevenue / 1000000 AS hit_revenue
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`,
    UNNEST (hits) AS hits
WHERE
    fullVisitorId = '8016003971239765913'
ORDER BY
    hits.hitNumber