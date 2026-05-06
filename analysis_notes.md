# Notes Taken During Analysis
---
The analysis normally starts with the project framing where I answer:
1. What is the product?
2. Who is the user?
3. WHat is the core value action?
4. What does the business want more of?
5. What is the analysis trying to decide?
...and then for this specific dataset
6. WHat did the scale query tell us about the business?

However, although I've written some queries in BigQueries, I intend to properly
explore it and use it well esoecially since this is a GA dataset even though there are easier ways to go about this like using preflattened versions on kaggle or 
converting a sample to csv and usinee pandas.

I need to work on myself. Why do I always want to do hard things? This conqueror 
lifestyle shaaaa...

So I'll be doing the majority of it in BigQuery until I can't use it anymore, cos
I still need visualizations. We'll see how it goes.

### Query One
The first query was targeted at the tables in the google analytics sample dataset.
ON examining it, we have the major google-ecommerce-dataset-table, then we have the tables for the daily visits and the daily total visits. Apart from these three, the 
session tables for each day from August !st, 2016 till July 19th, 2017.

But that's just at a glance. We still need to study it more...


05.05.2026
---
To move forward in this project I intend to answer the project framing questions:
1. What is the product?
2. Who is the user?
3. What is the core value action?
4. What does the business want more of?
5. What is this analysis trying to decide?

These are the core questions I intend to answer first and build from.
It requires me to run some queries on BigQuery though.

Now, in answering the first question I found thi:
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

For the second question, we find:
-- we have 714000+ distinct IDs, basically uers, coming in with 
-- sessions being on the upside of 903,000 which is 1.26 
-- sessions per user on average. This means we generally have multiple sessions 
-- per user which means they decide in multiple sessions and 
-- not in each and every session they have. We can suspect that the
-- user is the decision maker here. The next question is how many of 
-- the users make a purchase, how many sessions it takes for the users
-- to buy, and we can explore the user journey to see where we need to 
-- improve first to give us what we want

For the third question:
-- Clearly, our core value is a completed purchase, and the way
-- to see that is by the transaction record

...then based on what I have seen so far:
-- Now that we have limited it to users that have had actual
-- transactions the number of users reduced from 714,167 to
-- 10,022. That shows us that these 10,022 users (1.4% of total 
-- enterant users) did all the transactions. This raises a 
-- suspicion though: we have to check why all these users are not
-- buying and which type of users end up buying so we can increase
--them based on their persona.

-- Then haveing only 11,552 purchasing sessions shows that we
-- truly have multiple sessions before the purchasing session. We 
-- have only 1.2% of all the sessions being purchasing sessions.
-- Obviously, the percentage of purchasing users affects this percentage 
-- but it also shows that among these purchasing users, there are multiple 
-- purchasers.

-- To that end, we have 1.15 purchases per user on average. We can suspect
-- that our retention is not the best it can be since our average is this
-- low. Something might be hidden in the segmentations. We need to explore that.

Setting this aside,

For the fourth question:
-- Quite frankly, for a business hat brings in 714k users but
-- only has 11k+ purchases, we have an issue that requires
-- converting more of the users into purchasers because only
-- 1.4% of the enterant users are purchasing (on average).

-- Having a revenue of $1.54M signifies good purchases from 
-- the purchasing users so we can suspect that our revenue will
-- increase to a good extent if we can convert more to purchasers.

-- We can therefore conclude that making more of the users into purchasers
-- (conversion rate) will give us more of what we need: more revenue

FOr the fifth question:
-- We observe that since the goal of the analysis is to increase revenue
-- we need to ascertain the points where the leaks in the user journey are
-- and plug those.

-- To do that we will find the biggest drop-off point first, segment it,
-- find out what the behavioral differences between purchasers and 
-- non-purchasers, then the differences between one-time buyers and repeat
-- buyers so we can maximize revenue.

-- Explicitly stated, the decision this analysis will inform is where we 
-- should focus optimization efforts to convert visitors to purchasers 
-- and then into repeat purchasers.

At this point we are done with the PROJECT FRAMING SESSION and can now 
move with understanding towards the main goal.