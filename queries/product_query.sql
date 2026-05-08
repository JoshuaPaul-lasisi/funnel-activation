SELECT
    product.v2ProductName,
    SUM(product.productQuantity) AS units_sold,
    SUM(product.productRevenue) / 1e6 AS revenue
FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
    UNNEST (hits) AS hits,
    UNNEST (hits.product) AS product
WHERE
    hits.eCommerceAction.action_type = '6' -- purchase
GROUP BY
    product.v2ProductName
ORDER BY
    revenue DESC
    -- The google merchandise store provides google merch as its
    -- products. They span from hoodies to shirts to caps and even 
    -- stickers. So it's a large variety of products with the
    -- commonality being the GOOGLE branding on al of them. So in
    -- a nutshell we could say its a one-stop shop for GOOGLE-branded
    -- stuff and only that. So it's not in any competition so to say
    -- when we speak about another source of getting what we sell here.
    -- Also the store runs on direct purchase system from the 
    -- online store. It's a view-cart-checkout system. You could say 
    -- it's DIY. 
    -- Based on observation the top guys based on revenue are the 
    -- zip hoodie, water bottles, and journal. There's more tho and its for later.