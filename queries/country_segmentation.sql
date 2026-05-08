WITH
    all_sessions AS (
        SELECT
            geoNetwork.country,
            COUNT(DISTINCT visitId) AS sessions
        FROM
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`
        GROUP BY
            country
            -- to get all the visits per source
    ),
    product_views AS (
        SELECT
            geoNetwork.country,
            COUNT(DISTINCT visitId) AS viewers
        FROM
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST (hits) AS h
        WHERE
            h.eCommerceAction.action_type = '2'
        GROUP BY
            country
            -- amount of viewers per source
    )
SELECT
    a.country,
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
    end as country_quality
FROM
    all_sessions a
    LEFT JOIN product_views p ON a.country = p.country
WHERE
    a.sessions >= 100
ORDER BY
    country_quality DESC,
    product_view_rate DESC,
    a.country DESC;