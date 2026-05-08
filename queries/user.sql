select
    count(distinct fullVisitorId) as users,
    count(visitId) as sessions
from
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
    -- we have 714000+ distinct IDs, basically uers, coming in with 
    -- sessions being on the upside of 903,000 which is 1.26 
    -- sessions per user on average. This means we generally have multiple sessions 
    -- per user which means they decide in multiple sessions and 
    -- not in each and every session they have. We can suspect that the
    -- user is the decision maker here. The next question is how many of 
    -- the users make a purchase, how many sessions it takes for the users
    -- to buy, and we can explore the user journey to see where we need to 
    -- improve first to give us what we want