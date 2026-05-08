WITH
    all_sessions AS (
        SELECT
            p.v2ProductName,
            COUNT(DISTINCT visitId) AS sessions
        FROM
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            unnest (hits) as h,
            unnest (h.product) as p
        GROUP BY
            v2ProductName
            -- to get all the visits per source
    ),
    product_views AS (
        SELECT
            p.v2ProductName,
            COUNT(DISTINCT visitId) AS viewers
        FROM
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            unnest (hits) as h,
            unnest (h.product) as p
        WHERE
            h.eCommerceAction.action_type = '2'
        GROUP BY
            v2ProductName
            -- amount of viewers per source
    )
SELECT
    a.v2ProductName,
    a.sessions,
    p.viewers,
    (
        round(safe_divide(p.viewers, a.sessions) * 100, 2)
    ) as product_view_rate,
    case
        when (
            round(safe_divide(p.viewers, a.sessions) * 100, 2)
        ) < 10 then 'low desirability'
        when (
            round(safe_divide(p.viewers, a.sessions) * 100, 2)
        ) > 60 then 'high desirability'
        else 'mid desirability'
    end as product_desirability
FROM
    all_sessions a
    LEFT JOIN product_views p ON a.v2ProductName = p.v2ProductName
WHERE
    a.sessions >= 100
    AND p.viewers is not null
    AND (
        round(safe_divide(p.viewers, a.sessions) * 100, 2)
    ) > 1
ORDER BY
    product_desirability DESC,
    product_view_rate DESC,
    a.v2ProductName DESC;