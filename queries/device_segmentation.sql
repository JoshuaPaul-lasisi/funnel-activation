WITH
    all_sessions AS (
        SELECT
            device.deviceCategory,
            COUNT(DISTINCT visitId) AS sessions
        FROM
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`
        GROUP BY
            deviceCategory
            -- to get all the visits per source
    ),
    product_views AS (
        SELECT
            device.deviceCategory,
            COUNT(DISTINCT visitId) AS viewers
        FROM
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST (hits) AS h
        WHERE
            h.eCommerceAction.action_type = '2'
        GROUP BY
            deviceCategory
            -- amount of viewers per source
    )
SELECT
    a.deviceCategory,
    a.sessions,
    p.viewers,
    (
        round(safe_divide(p.viewers, a.sessions) * 100, 2)
    ) as product_view_rate,
    case
        when (
            round(safe_divide(p.viewers, a.sessions) * 100, 2)
        ) < 10 then 'low quality'
        when (
            round(safe_divide(p.viewers, a.sessions) * 100, 2)
        ) > 60 then 'high quality'
        else 'mid quality'
    end as device_quality
FROM
    all_sessions a
    LEFT JOIN product_views p ON a.deviceCategory = p.deviceCategory
WHERE
    a.sessions >= 100
ORDER BY
    device_quality DESC,
    product_view_rate DESC,
    a.deviceCategory DESC;