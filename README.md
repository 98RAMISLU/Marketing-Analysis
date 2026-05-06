# Marketing Analytics Dashboard

A comprehensive marketing analysis project combining SQL data cleaning, Python sentiment analysis, and Power BI visualizations to provide actionable insights into customer behavior, product performance, and marketing effectiveness.

---

## 📋 Project Overview

This project analyzes marketing data across multiple dimensions:
- **Customer engagement** (clicks, views, likes)
- **Product performance** (by category and price)
- **Customer sentiment** (from reviews using NLP)
- **Conversion rates** (from browsing to purchase)
- **Customer journey** (touchpoints and interactions)

---

## 🛠️ Technologies Used

- **SQL Server** — Data extraction and cleaning
- **Python 3.x** — Sentiment analysis using VADER
- **Power BI Desktop** — Interactive dashboard and visualizations
- **Libraries:**
  - `pandas` — Data manipulation
  - `pyodbc` — SQL database connection
  - `nltk` — Natural Language Processing (VADER Sentiment Analysis)

---

## 📁 Project Structure

```
Marketing_Analytics_Project/
│
├── SQL/
│   ├── SQLQuery1.sql          # Product data cleaning & validation
│   ├── SQLQuery2.sql          # Customer & Geography joins
│   ├── SQLQuery3.sql          # Customer reviews cleaning
│   ├── SQLQuery4.sql          # Engagement data transformation
│   └── SQLQuery5.sql          # Customer journey deduplication
│
├── Python/
│   └── customer_sentiment_analysis.py    # Sentiment scoring & categorization
│
├── Power_BI/
│   └── marketing_dashboard.pbix          # Interactive dashboard
│
└── Data/
    └── customer_sentiment_analysis.csv   # Output from Python analysis
```

---

## 🔄 Data Pipeline

### 1️⃣ SQL Data Cleaning

**Products Table:**
- Validate product names (no NULLs)
- Create price categories (Low/Medium/High)
- Check for unmatched ProductIDs

**Customers Table:**
- Join with geography data
- Validate customer information
- Remove duplicates

**Reviews Table:**
- Clean text (remove extra spaces)
- Format review dates
- Validate ratings

**Engagement Data:**
- Split combined views/clicks column
- Standardize content types (e.g., "Socialmedia" → "Social Media")
- Format dates (dd-MM-yyyy)
- Remove newsletter data

**Customer Journey:**
- Identify and remove duplicate records
- Fill missing durations with average values
- Standardize stage names (UPPER case)
- Keep first occurrence of duplicate journeys

### 2️⃣ Python Sentiment Analysis

Using VADER (Valence Aware Dictionary and sEntiment Reasoner):

```python
- Calculate sentiment score (-1.0 to 1.0)
- Categorize sentiment (Positive, Negative, Mixed, Neutral)
- Create sentiment buckets for distribution analysis
- Combine with rating to provide context
```

**Sentiment Categories:**
- **Positive** — Score ≥ 0.05 AND Rating ≥ 4
- **Negative** — Score ≤ -0.05 AND Rating ≤ 2
- **Mixed Positive** — Conflicting signals
- **Mixed Negative** — Conflicting signals
- **Neutral** — Score close to 0

### 3️⃣ Power BI Dashboard

**Sections:**
- **Overview** — KPIs and summary metrics
- **Social Media Analysis** — Engagement by platform
- **Conversion Rates** — Visitor to purchase funnel
- **Customer Reviews** — Sentiment distribution and ratings
- **Progress Tracking** — Trends over time

**Slicers:**
- Year filter (2023-2025)
- Product Name filter
- Content Type filter

---

## 📊 Key Metrics

| Metric | Definition |
|---|---|
| **Total Clicks** | Sum of clicks from all engagement |
| **Conversion Rate** | (Total Purchases / Total Views) × 100 |
| **Avg Rating** | Average customer review rating |
| **Sentiment Distribution** | % of Positive/Negative/Neutral reviews |
| **Customer Journey** | Stages: View → Add to Cart → Purchase |

---

## 🚀 How to Run This Project

### Prerequisites
```
- SQL Server (SSMS installed)
- Python 3.8+
- Power BI Desktop
- pip packages: pandas, pyodbc, nltk
```

### Step 1: Run SQL Queries
```sql
1. Run SQLQuery1.sql → Products cleaning
2. Run SQLQuery2.sql → Customer validation
3. Run SQLQuery3.sql → Reviews cleaning
4. Run SQLQuery4.sql → Engagement transformation
5. Run SQLQuery5.sql → Journey deduplication
```

### Step 2: Run Python Sentiment Analysis
```bash
python customer_sentiment_analysis.py
```
**Output:** `customer_sentiment_analysis.csv`

### Step 3: Load into Power BI
1. Open `marketing_dashboard.pbix`
2. Import `customer_sentiment_analysis.csv`
3. Create relationships between tables
4. Refresh all data

---

## 🔍 Data Quality Issues Fixed

✅ **Removed blanks** from ProductID and EngagementDate  
✅ **Eliminated duplicates** in customer journey (196 duplicates removed)  
✅ **Filled missing values** (Duration filled with date averages)  
✅ **Standardized formats** (ContentType, dates, text)  
✅ **Validated relationships** (All ProductIDs matched to products)  

---

## 📈 Key Findings

- **Conversion Rate:** Calculated from View → Purchase journey
- **Best Performing Products:** Identified by click volume and conversion
- **Customer Sentiment:** Majority positive reviews with actionable negative feedback
- **Peak Engagement:** Seasonal patterns identified by year/month
- **Social Media Impact:** Engagement metrics tracked by content type

---

## 🎯 Dashboard Features

**Interactive Slicers:**
- Filter by Year (2023, 2024, 2025)
- Filter by Product Name (20 products)
- Filter by Content Type (Social Media, Blog, Email, etc.)

**Dynamic Measures:**
- Clicks (SUM with IF statement to handle blanks)
- Conversion Rate (DIVIDE with safe error handling)
- Customer Review Count
- Average Sentiment Score
- Likes by Platform

**Visuals:**
- Card visuals for KPIs
- Matrix tables for detailed data
- Charts for trends and distributions
- Sentiment analysis breakdown

---

## 📝 Database Schema

### Tables Used
1. **Products** — ProductID, ProductName, Price
2. **Customers** — CustomerID, CustomerName, Email, Gender
3. **Geography** — GeographyID, City, Country
4. **Engagement_Data** — Views, Clicks, Likes, CampaignID
5. **Customer_Reviews** — ReviewID, Rating, ReviewText, ReviewDate
6. **Customer_Journey** — JourneyID, Stage (View→Cart→Purchase), Duration
7. **Customer_Sentiment** — SentimentScore, SentimentCategory (from Python)

---

## 🔗 Relationships (Power BI Model)

```
Dim_Products ←→ Fact_EngagementData
Dim_Products ←→ Fact_CustomerReviews
Dim_Products ←→ Fact_CustomerJourney
Dim_Products ←→ Fact_CustomerSentiment

Dim_Customers ←→ Fact_CustomerJourney
Dim_Customers ←→ Fact_CustomerReviews

Calendar ←→ All Fact Tables (Date relationships)
```

---

## 🐛 Troubleshooting

**Issue:** (Blank) appears in slicer
**Fix:** Ensure relationship exists between fact table and dimension on correct column

**Issue:** DAX measures showing "--" instead of values
**Fix:** Use `IF(ISBLANK(...), 0, value)` in measure formula

**Issue:** Python sentiment analysis fails
**Fix:** Ensure VADER lexicon is downloaded: `nltk.download('vader_lexicon')`

---

## 📚 Files Included

| File | Purpose |
|---|---|
| `SQLQuery1-5.sql` | Data cleaning and transformation scripts |
| `customer_sentiment_analysis.py` | Python NLP sentiment analysis |
| `marketing_dashboard.pbix` | Power BI interactive dashboard |
| `customer_sentiment_analysis.csv` | Output CSV from Python analysis |
| `README.md` | This documentation |

---

## 🎓 Learning Outcomes

✅ SQL data cleaning and validation  
✅ Database relationships and joins  
✅ Python NLP with VADER sentiment analysis  
✅ Power BI data modeling and DAX measures  
✅ Building interactive dashboards  
✅ Handling edge cases (NULLs, duplicates, mismatches)  

---

## 📞 Support

For questions or issues:
1. Check the troubleshooting section
2. Review the SQL queries for data validation
3. Verify all relationships in Power BI Model View
4. Ensure Python libraries are installed: `pip install pandas pyodbc nltk`

---

## 📄 License

This project is for educational and portfolio purposes.

---

**Last Updated:** May 6, 2026  
**Version:** 1.0

---

## 🏆 Project Summary

This marketing analytics project demonstrates:
- **Data Engineering:** SQL data cleaning and transformation
- **Machine Learning:** Python sentiment analysis using NLP
- **Business Intelligence:** Power BI dashboard design and DAX calculations
- **Problem Solving:** Handling data quality issues and relationship management

A complete end-to-end analytics solution ready for business decision-making!
