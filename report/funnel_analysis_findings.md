# Google Merchandise Store — Funnel & Activation Analysis
**Dataset:** Google Analytics Sample (BigQuery Public Data)
**Analyst:** Joshua Paul-lasisi
**Period Covered:** August 2016 – July 2017
**Tool:** Google BigQuery (SQL) + Python (visualisation)

---

## Executive Summary

This analysis set out to identify where the Google Merchandise Store loses visitors before they convert to buyers, and what interventions would have the highest impact on revenue.

The answer is unexpected: **the problem is not in the checkout funnel — it is before it.** 86% of all sessions end without a single product being viewed. The store attracts over 900,000 sessions annually but converts only 1.34% to purchases. Segmenting by traffic source, device, and geography reveals no high-performing segment — the low engagement rate is consistent across all dimensions. The data points to a fundamental product desirability challenge, not a funnel optimisation problem. Sending more traffic to this funnel will not meaningfully improve revenue until the product's ability to generate genuine interest is addressed.

---

## Business Context

The Google Merchandise Store sells Google-branded physical goods — apparel, accessories, and stationery — exclusively online. Revenue is generated per transaction in a direct view-to-cart-to-checkout model with no subscription component.

**Scale (Aug 2016 – Jul 2017):**

| Metric | Value |
|---|---|
| Total sessions | 903,653 |
| Unique visitors | 714,167 |
| Sessions per visitor | 1.26 average |
| Purchasing users | 10,022 (1.4% of visitors) |
| Total transactions | 12,115 |
| Total revenue | $1,780,149 |
| Average order value | ~$147 |
| Session conversion rate | 1.34% |

The 1.26 sessions per visitor average indicates most users make their purchase decision across multiple visits — they browse, leave, and return. The 1.34% session conversion rate is significantly below the 2–4% e-commerce industry benchmark.

**The business question:** With healthy average order value ($147) but low conversion volume, where should optimization effort be focused to increase revenue?

---

## The Funnel

The acquisition funnel from session entry to purchase:

| Step | Sessions | % of Previous Step |
|---|---|---|
| All sessions | 886,303 | 100% |
| Viewed a product | 123,692 | 14% |
| Added to cart | 50,022 | 40% |
| Entered checkout | 22,371 | 45% |
| Completed purchase | 11,549 | 52% |

**The finding is immediate:** once a visitor views a product, the funnel performs reasonably well — 40% add to cart, 45% enter checkout, 52% complete purchase. These are not exceptional conversion rates but they are functional. The funnel is not broken from product view onwards.

The catastrophic leak is before product viewership. **86% of sessions end without a single product being viewed.** This is not a checkout problem, a cart abandonment problem, or a checkout friction problem. It is a pre-engagement problem — visitors are arriving and leaving before they ever see what the store sells.

---

## Segmentation Analysis

### By Traffic Source

275 unique traffic sources were identified. After filtering to sources with 100+ sessions (to ensure statistical reliability), sources were classified by product view rate:

- **High quality** (>60% view rate): None after filtering for minimum volume
- **Mid quality** (10–60% view rate): A small number of direct and organic sources
- **Low quality** (<10% view rate): The majority, including high-volume paid sources

**Key finding:** Several high-volume sources show critically low product view rates:

| Source | Implication |
|---|---|
| m.facebook.com | Mobile social traffic not engaging |
| t.co (Twitter) | Social referral not converting to interest |
| youtube.com | Video referral not translating |
| reddit.com | Community referral not engaging |
| baidu | International search not engaging |
| analytics.google.com | Internal/developer traffic, not buyers |

These sources collectively drive significant session volume but produce minimal product engagement. Spend allocated to these channels is not generating proportional value.

**Implication:** The traffic quality problem is not isolated to one channel. It is systemic across paid and organic social sources — suggesting the issue is not the channel itself but the mismatch between what these channels promise and what the store delivers.

### By Device

All device categories (desktop, mobile, tablet) showed similarly low product view rates. No device type demonstrated meaningfully better engagement. This rules out a device-specific UX problem as the primary cause.

### By Geography

121 countries met the minimum session threshold. Of these:
- 30 countries were above the low-quality threshold
- 0 countries qualified as high-quality (>60% product view rate)

The consistent low engagement across all geographies, all devices, and all traffic sources points to a single conclusion: this is not a targeting, UX, or channel problem. It is a product interest problem.

---

## Product Desirability Analysis

After removing null product entries, 490 unique products were analysed by view rate. The majority registered view rates below 1% — meaning the overwhelming majority of visitors who did reach product pages showed no meaningful engagement with individual products.

Only one product category registered mid-level desirability. No products registered high desirability scores.

**The strategic insight:** The Google Merchandise Store occupies a unique market position — it has no direct competitor for Google-branded goods. But uniqueness is not the same as desirability. The data suggests the store has not yet established the kind of brand statement in the apparel and lifestyle space that drives organic purchase intent.

Products like the zip hoodie (top revenue driver), water bottle, and journal sell because they are functional items with incidental Google branding — not because the Google brand itself drives aspiration in the way that luxury or streetwear brands do. Louis Vuitton and Supreme command premium engagement because wearing their brand makes a social statement. Google merchandise does not yet make that statement at scale.

This matters because the conventional response to low conversion — "drive more traffic" — is unlikely to work here. Additional traffic into a funnel where 86% of visitors disengage before seeing a product will produce proportionally more disengaged visitors, not more buyers.

---

## Findings Summary

| Finding | Evidence | Implication |
|---|---|---|
| 86% of sessions never view a product | Funnel data | Pre-engagement is the primary leak |
| Funnel works once engaged | 40-52% conversion from view onwards | Don't optimise checkout — fix top of funnel |
| No traffic source converts well | Source segmentation | Not a channel allocation problem |
| No device converts well | Device segmentation | Not a UX/mobile problem |
| No geography converts well | Country segmentation | Not a targeting problem |
| Product view rates mostly below 1% | Product analysis | Weak intrinsic product interest |
| Consistent pattern across all dimensions | All segmentations | Systemic, not tactical |

---

## Recommendations

**1. Do not increase traffic spend before addressing product interest.**
Driving more sessions into a funnel where 86% disengage before product viewership will scale the problem, not solve it. The expected return on additional acquisition spend is low until the pre-engagement problem is solved.

**2. Investigate the brand statement the store wants to make.**
The top-selling products (zip hoodie, water bottle, journal) are functional items. The store should determine whether it wants to compete as a lifestyle/apparel brand — which requires brand investment beyond Google's corporate identity — or focus on positioning as a fan store for Google enthusiasts and employees, which is a smaller but more genuinely engaged addressable market.

**3. Audit and reduce low-quality traffic sources.**
Sources including m.facebook.com, t.co, reddit.com, and youtube.com drive meaningful session volume with minimal engagement. Reducing or retargeting spend on these channels would improve the signal-to-noise ratio of the funnel and reduce wasted acquisition cost.

**4. Double down on what works.**
Direct and organic search traffic shows relatively better engagement. Investment in SEO, Google Shopping listings, and email marketing to existing customers would target higher-intent visitors.

**5. Investigate the 10,022 buyers deeply.**
1.4% of visitors convert. Understanding who they are, where they come from, and what they searched before arriving would allow acquisition targeting to be refined toward the persona most likely to buy — rather than chasing volume from unengaged audiences.

---

## Limitations

- The dataset covers August 2016 – July 2017. Product catalogue, pricing, and marketing strategy may have changed significantly since then.
- fullVisitorId is a cookie-based identifier — cross-device behaviour from the same user may be counted as separate visitors, slightly understating true visitor counts.
- The analysis cannot distinguish between genuine organic interest and internal Google employee traffic, which may inflate session volume without representing real market demand.
- Product desirability analysis is based on view rates within the dataset — it does not capture external search demand or social sentiment around specific products.
