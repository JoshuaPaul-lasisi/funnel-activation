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