# Google Merchandise Store — Funnel & Activation Analysis

A product analytics case study identifying where the Google Merchandise Store loses visitors before they convert to buyers — and why the answer is not what the funnel initially suggests.

---

## The Business Question

The Google Merchandise Store attracts over 900,000 sessions annually but converts only ~1.34% to purchases — well below the 2–4% e-commerce industry benchmark. This analysis investigates where in the user journey the biggest losses occur and what interventions would have the highest impact on revenue.

---

## The Core Finding

**86% of all sessions end without a single product being viewed.**

Once a visitor views a product, the funnel performs reasonably:
- 40% add to cart
- 45% enter checkout
- 52% complete purchase

The problem is not checkout friction, cart abandonment, or UX. It is pre-engagement. Segmenting by traffic source, device type, and geography reveals the same low engagement pattern across every dimension — no channel, device, or country converts well. The evidence points to a product desirability challenge, not a funnel optimisation problem.

---

## Dataset

**Source:** [Google Analytics Sample — BigQuery Public Data](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=google_analytics_sample)

**Period:** August 2016 – July 2017

**Structure:** One table per day (`ga_sessions_YYYYMMDD`), containing session-level data with nested `hits` arrays capturing every user action.

**Key schema fields used:**

| Field | Description |
|---|---|
| `fullVisitorId` | Unique visitor identifier |
| `totals.transactions` | Transactions completed in session |
| `totals.totalTransactionRevenue` | Revenue in micros (÷1,000,000 for USD) |
| `trafficSource.source/medium` | How the visitor arrived |
| `device.deviceCategory` | Desktop, mobile, or tablet |
| `geoNetwork.country` | Visitor geography |
| `hits.eCommerceAction.action_type` | Funnel step (1=view list, 2=view product, 3=add to cart, 5=checkout, 7=purchase) |

---

## Project Structure

```
FUNNEL-ACTIVATION/
│
├── data/
│   ├── country_summary.csv          # Country-level funnel results
│   ├── device_summary.csv           # Device-level funnel results
│   ├── funnel_results.csv           # Overall funnel step counts
│   ├── product_desirability.csv     # Product view rate analysis
│   └── traffic_quality.csv         # Traffic source quality segmentation
│
├── report/
│   └── funnel_analysis_findings.md  # Full findings and recommendations
│
├── sql/
│   ├── main/
│   │   ├── 01_funnel.sql            # Overall acquisition funnel
│   │   ├── 02_traffic_segmentation.sql
│   │   ├── 03_device_segmentation.sql
│   │   ├── 04_country_segmentation.sql
│   │   └── 05_product_desirability.sql
│   └── others/
│       ├── business_need.sql        # Scale and business context queries
│       ├── core_value.sql           # Transaction and revenue queries
│       ├── large_traffic_segmentation.sql
│       ├── product_query.sql
│       ├── session_exploration.sql
│       ├── user_journey.sql
│       └── user.sql
│
├── visuals/
│   ├── funnel_chart.png
│   ├── product_view_distribution.png
│   └── source_quality_bar.png
│
├── analysis_notes.md                # Running notes taken during analysis
├── notebook.ipynb                   # Python visualisation notebook
└── README.md
```

---

## Methodology

### Tools
- **Google BigQuery** — all data querying and funnel construction
- **Python (pandas, matplotlib, seaborn)** — visualisation
- **Jupyter Notebook** — analysis environment

### Funnel Definition

Each funnel step is defined by the presence of a specific `eCommerceAction.action_type` value within a session's `hits` array:

| Step | Action Type | Definition |
|---|---|---|
| All sessions | — | Any session in the dataset |
| Product viewed | 2 | At least one product detail view |
| Added to cart | 3 | At least one add-to-cart event |
| Entered checkout | 5 | At least one checkout initiation |
| Purchased | Transaction | `totals.transactions >= 1` |

Sessions are counted at each step using `COUNTIF` within a CTE chain — a session qualifies for a step if it contains at least one hit of that action type.

### Traffic Quality Classification

Traffic sources were classified by product view rate (sessions with a product view ÷ total sessions from that source):

| Classification | View Rate Threshold |
|---|---|
| High quality | > 60% |
| Mid quality | 10% – 60% |
| Low quality | < 10% |

Sources with fewer than 100 sessions were excluded from quality classification to avoid unreliable small-sample conclusions.

---

## Key Results

| Metric | Value |
|---|---|
| Session conversion rate | ~1.34% |
| Product view rate | 14% of all sessions |
| Cart-to-checkout rate | 45% |
| Checkout-to-purchase rate | 52% |
| High-quality traffic sources | 0 (after volume filtering) |
| High-quality countries | 0 (after volume filtering) |
| High-quality devices | 0 |

---

## Recommendations

1. **Do not increase traffic spend before addressing product interest** — more traffic into an 86% pre-engagement dropout rate will scale the problem, not solve it
2. **Investigate the brand statement the store wants to make** — functional Google-branded products need a reason for external buyers to seek them out
3. **Audit and reduce low-quality traffic sources** — m.facebook.com, t.co, reddit.com, and youtube.com drive high volume with minimal engagement
4. **Double down on direct and organic search** — higher-intent channels show relatively better engagement
5. **Deep-dive into the 1.4% who do buy** — understanding the buyer persona enables better acquisition targeting

---

## How to Run

### BigQuery Queries

1. Go to [BigQuery Console](https://console.cloud.google.com/bigquery)
2. The dataset is publicly available — no download needed
3. Run SQL files from `sql/main/` in numbered order (01 → 05)
4. Export results using **Save Results → CSV** for each query
5. Place exported CSVs in the `data/` folder

### Python Visualisations

```bash
# Install dependencies
pip install pandas matplotlib seaborn jupyter

# Launch notebook
jupyter notebook notebook.ipynb
```

The notebook reads from the `data/` folder — run BigQuery queries and export CSVs first.

---

## Author

**Joshua Paul Lasisi**
Product Analyst | Data Analyst
[LinkedIn](https://linkedin.com/in/joshuapaul-lasisi) | [GitHub](https://github.com/JoshuaF) | [Portfolio](https://sky-knight-aae.notion.site/Joshua-Paul-lasisi-35bcf45b658580568f9df2f33bdd7cb4)
