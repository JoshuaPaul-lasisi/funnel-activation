WITH
    all_sessions AS (
        SELECT
            trafficSource.source,
            COUNT(DISTINCT visitId) AS sessions
        FROM
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`
        GROUP BY
            source
            -- to get all the visits per source
    ),
    product_views AS (
        SELECT
            trafficSource.source,
            COUNT(DISTINCT visitId) AS viewers
        FROM
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST (hits) AS h
        WHERE
            h.eCommerceAction.action_type = '2'
        GROUP BY
            source
            -- amount of viewers per source
    )
SELECT
    a.source,
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
    end as traffic_quality
FROM
    all_sessions a
    LEFT JOIN product_views p ON a.source = p.source
WHERE
    a.sessions >= 100
ORDER BY
    traffic_quality DESC,
    product_view_rate DESC,
    a.sessions DESC;