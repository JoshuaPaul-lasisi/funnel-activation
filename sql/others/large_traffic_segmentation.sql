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
    ),
    add_to_cart AS (
        SELECT
            trafficSource.source,
            COUNT(DISTINCT visitId) AS carters
        FROM
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST (hits) AS h
        WHERE
            h.eCommerceAction.action_type = '3'
        GROUP BY
            source
            -- amount of visitors per source
    ),
    checkout AS (
        SELECT
            trafficSource.source,
            COUNT(DISTINCT visitId) AS checkers
        FROM
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST (hits) AS h
        WHERE
            h.eCommerceAction.action_type = '5'
        GROUP BY
            source
            -- amount of visitors that got to the checkout stage per source
    ),
    purchase AS (
        SELECT
            trafficSource.source,
            COUNT(DISTINCT visitId) AS purchasers
        FROM
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST (hits) AS h
        WHERE
            h.eCommerceAction.action_type = '6'
        GROUP BY
            source
            -- amount of purchasers per source
    )
SELECT
    a.source,
    a.sessions,
    p.viewers,
    c.carters,
    o.checkers,
    e.purchasers
FROM
    all_sessions a
    LEFT JOIN product_views p ON a.source = p.source
    LEFT JOIN add_to_cart c ON p.source = c.source
    LEFT JOIN checkout o ON c.source = o.source
    LEFT JOIN purchase e ON o.source = e.source
ORDER BY
    a.sessions DESC;