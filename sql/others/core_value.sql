SELECT
    COUNT(DISTINCT fullVisitorId) AS users,
    COUNT(*) AS purchasing_sessions -- total.transactions
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE
    totals.transactions >= 1;

-- Clearly, our core value is a completed purchase, and the way
-- to see that is by the transaction record
-- Now that we have limited it to users that have had actual
-- transactions the number of users reduced from 714,167 to
-- 10,022. That shows us that these 10,022 users (1.4% of total 
-- enterant users) did all the transactions. This raises a 
-- suspicion though: we have to check why all these users are not
-- buying and which type of users end up buying so we can increase
--them based on their persona.
-- Then having only 11,552 purchasing sessions shows that we
-- truly have multiple sessions before the purchasing session. We 
-- have only 1.2% of all the sessions being purchasing sessions.
-- Obviously, the percentage of purchasing users affects this percentage 
-- but it also shows that among these purchasing users, there are multiple 
-- purchasers.
-- To that end, we have 1.15 purchases per user on average. We can suspect
-- that our retention is not the best it can be since our average is this
-- low. Something might be hidden in the segmentations. We need to explore that.