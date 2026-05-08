select
    sum(totals.transactionRevenue) / 1e6 as total_revenue,
    count(distinct fullVisitorId) as users,
    countif(totals.transactions >= 1) as purchasing_sessions
from
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
    -- Quite frankly, for a business hat brings in 714k users but
    -- only has 11k+ purchases, we have an issue that requires
    -- converting more of the users into purchasers because only
    -- 1.4% of the enterant users are purchasing (on average).
    -- Having a revenue of $1.54M signifies good purchases from 
    -- the purchasing users so we can suspect that our revenue will
    -- increase to a good extent if we can convert more to purchasers.
    -- We can therefore conclude that making more of the users into purchasers
    -- (conversion rate) will give us more of what we need: more revenue