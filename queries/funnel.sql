WITH
    all_sessions as (
        select distinct
            visitId
        from
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`
            -- to get all the visits that were made
    ),
    product_views as (
        select distinct
            visitId
        from
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            unnest (hits) as h
        where
            h.eCommerceAction.action_type = '2'
            -- amount of visitors that went through the products
    ),
    add_to_cart as (
        select distinct
            visitId
        from
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            unnest (hits) as h
        where
            h.eCommerceAction.action_type = '3'
            -- amount of visitors that added a product to cart
    ),
    checkout as (
        select distinct
            visitId
        from
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            unnest (hits) as h
        where
            h.eCommerceAction.action_type = '5'
            -- amount of visitors that got to the checkout stage
    ),
    purchase as (
        select distinct
            visitId
        from
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            unnest (hits) as h
        where
            h.eCommerceAction.action_type = '6'
            -- amount of purchasers
    )
select
    '1. All sessions' as step,
    count(*) as sessions,
    1.0 as pct_of_prev
from
    all_sessions
union all
select
    '2. Product view',
    count(*) as sessions,
    round(
        safe_divide(
            count(*),
            (
                select
                    count(*)
                from
                    all_sessions
            )
        ),
        2
    )
from
    product_views
union all
select
    '3. Add to cart',
    count(*) as sessions,
    round(
        safe_divide(
            count(*),
            (
                select
                    count(*)
                from
                    product_views
            )
        ),
        2
    )
from
    add_to_cart
union all
select
    '4. Checkout',
    count(*) as sessions,
    round(
        safe_divide(
            count(*),
            (
                select
                    count(*)
                from
                    add_to_cart
            )
        ),
        2
    )
from
    checkout
union all
select
    '5. Purchase',
    count(*) as sessions,
    round(
        safe_divide(
            count(*),
            (
                select
                    count(*)
                from
                    checkout
            )
        ),
        2
    )
from
    purchase
order by
    step;

-- Results show the largest drop-off is before 
-- viewing any products since only 14% of the 
-- visitors on the site do that. 
-- which clearly shows that our largest drop-off is pre-product_viewership. So 
-- its a traffic quality issue. The kind of people we're attracting are not getting
-- value from us. The percentage of visitors that are interested in what we have 
-- among the ones we have attracted are low.
-- Such a case requires that we segment them so we can find where the wrong and 
-- right customers are coming from. We should have a clearer view and be able
-- to make better decisions with that.