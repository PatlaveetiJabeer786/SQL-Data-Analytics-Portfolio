# 🍕 Pizza Sales Analysis — SQL + Power BI

[![Header](https://capsule-render.vercel.app/api?type=waving&color=0:FF6B35,100:F7C59F&height=200&section=header&text=Pizza%20Sales%20Analysis&fontSize=42&fontColor=ffffff&animation=fadeIn&fontAlignY=35&desc=SQL%20Server%20%2B%20Power%20BI%20End-to-End%20Project&descAlignY=58&descSize=18)](https://github.com/PatlaveetiJabeer786/Pizza-sales-Analysis-Project)

![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)
![Records](https://img.shields.io/badge/Dataset-48%2C000%2B%20Records-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed%20✅-brightgreen?style=for-the-badge)

---

## 📌 Project Overview

This is a **complete, end-to-end data analytics project** for a pizza restaurant chain — built using **SQL Server** for deep data analysis and **Power BI** for interactive visual storytelling.

The project analyzes **48,000+ real pizza orders** covering an entire year of business operations — uncovering what's selling, when customers order most, which pizzas are killing it, and which ones are quietly losing money.

The final deliverable is a **2-page interactive Power BI dashboard** that gives management everything they need to make smart, data-driven decisions about their menu, pricing, staffing, and marketing — all in one place.

---

## 🧩 Business Problem

> *"The pizza restaurant chain had a full year of transactional sales data sitting in CSV files — but no way to answer basic business questions: Which pizzas make us the most money? When are we busiest? What should we remove from the menu? Are we growing or declining?"*

**Without answers to these questions, the business was:**

- 🍕 Keeping **underperforming pizzas** on the menu — wasting ingredients and kitchen time
- 📅 **Understaffing on peak days** and overstaffing on slow days
- 💸 **Leaving revenue on the table** by not knowing which categories to promote
- 📉 Making **pricing decisions based on guesswork**, not actual sales data
- 🔍 Unable to track **month-over-month trends** or spot early warning signs

---

## 🎯 My Task as the Data Analyst

I was given the raw CSV dataset and asked to build a complete analytics solution:

| Task | What I Did | Tool |
|------|-----------|------|
| **Data Import** | Loaded 48,000+ order records into SQL Server | SQL Server |
| **Data Cleaning** | Fixed nulls, standardized formats, validated data types | SQL |
| **KPI Analysis** | Wrote queries for Revenue, Orders, Avg Order Value, Pizzas Sold | SQL |
| **Trend Analysis** | Extracted daily, weekly & monthly order patterns | SQL |
| **Best/Worst Analysis** | Ranked pizzas by Revenue, Quantity & Total Orders | SQL |
| **Category Analysis** | % Sales contribution by pizza category & size | SQL |
| **Dashboard Build** | 2-page interactive Power BI dashboard | Power BI + DAX |
| **Validation** | Cross-checked SQL results vs Power BI visuals for accuracy | Both |

---

## 📊 Dashboard Preview

### 🏠 Page 1 — Home Dashboard (KPI Tracking)
![Home Dashboard](https://github.com/PatlaveetiJabeer786/Pizza-sales-Analysis-Project/blob/main/Dash_Board_1.jpeg)

### 🏆 Page 2 — Best & Worst Sellers
![Best Worst Dashboard](https://github.com/PatlaveetiJabeer786/Pizza-sales-Analysis-Project/blob/main/Dash_Board_2.jpeg)

---

## 📈 Key Performance Indicators (KPIs)

| KPI | Value | What It Means |
|-----|-------|--------------|
| 💰 **Total Revenue** | **$817,860** | Gross sales for the full year |
| 🛒 **Total Orders** | **21,350** | Number of customer transactions |
| 🍕 **Total Pizzas Sold** | **49,574** | Total volume of pizzas moved |
| 💵 **Avg Order Value** | **$38.31** | How much a customer spends per visit |
| 📦 **Avg Pizzas per Order** | **2.32** | Customers tend to order 2–3 pizzas |

---

## 🔍 My SQL Analysis — Step by Step

### ✅ Step 1 — KPI Queries

```sql
-- Total Revenue
SELECT ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales;

-- Average Order Value
SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS Avg_Order_Value
FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

-- Average Pizzas Per Order
SELECT CAST(
    CAST(SUM(quantity) AS DECIMAL(10,2)) /
    CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order
FROM pizza_sales;
```

---

### ✅ Step 2 — Trend Analysis

```sql
-- Daily Order Trend
SELECT
    DATENAME(DW, order_date) AS Order_Day,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_Orders DESC;

-- Monthly Order Trend
SELECT
    DATENAME(MONTH, order_date) AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC;
```

---

### ✅ Step 3 — Sales by Category & Size

```sql
-- % Sales by Pizza Category
SELECT
    pizza_category,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
    CAST(SUM(total_price) * 100 /
         (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category
ORDER BY PCT DESC;

-- % Sales by Pizza Size
SELECT
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
    CAST(SUM(total_price) * 100 /
         (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;
```

---

### ✅ Step 4 — Best & Worst Sellers

```sql
-- TOP 5 Pizzas by Revenue
SELECT TOP 5 pizza_name,
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- BOTTOM 5 Pizzas by Revenue
SELECT TOP 5 pizza_name,
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

-- TOP 5 Pizzas by Quantity Sold
SELECT TOP 5 pizza_name,
    SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;

-- BOTTOM 5 Pizzas by Quantity Sold
SELECT TOP 5 pizza_name,
    SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC;
```

---

## 📊 Power BI Dashboard — What I Built

### 🏠 Page 1 — Home Dashboard

| Visual | Purpose |
|--------|---------|
| 📊 **KPI Cards** | Total Revenue, Orders, Pizzas Sold, AOV, Avg Pizzas/Order |
| 📉 **Daily Trend Bar Chart** | Shows which days of the week are busiest |
| 📈 **Monthly Trend Line Chart** | Tracks revenue and order volume across all 12 months |
| 🍩 **Donut Chart — Category** | % Revenue split across Classic, Supreme, Chicken, Veggie |
| 🍩 **Donut Chart — Size** | % Revenue by pizza size (S, M, L, XL, XXL) |
| 📊 **Funnel Chart** | Orders by pizza category ranked visually |

### 🏆 Page 2 — Best & Worst Sellers

| Visual | Purpose |
|--------|---------|
| 🥇 **Top 5 by Revenue** | Highest earning pizzas — where to invest marketing |
| 💀 **Bottom 5 by Revenue** | Lowest earning pizzas — menu removal candidates |
| 🥇 **Top 5 by Quantity** | Most frequently ordered — customer favorites |
| 💀 **Bottom 5 by Quantity** | Least ordered — possible discontinuation list |
| 🥇 **Top 5 by Total Orders** | Pizzas that appear in the most transactions |
| 💀 **Bottom 5 by Total Orders** | Pizzas customers rarely choose |

---

## 💡 Key Business Insights & Outcomes

### 📅 When Are Customers Ordering?

- **Fridays and Thursdays** are the busiest days — peak demand end-of-week
- **July** is the highest revenue month — summer seasonality confirmed
- **Sunday** has the lowest orders — a clear understaffing risk
- **12 PM – 1 PM and 5 PM – 8 PM** are the two peak ordering windows daily

### 🍕 Which Categories Perform Best?

- **Classic pizzas** contribute the most to both revenue and total orders
- **Supreme and Chicken** categories have higher average order values
- **Veggie** category underperforms in both revenue and volume

### 📏 What Sizes Do Customers Prefer?

- **Large (L)** is the most popular size — highest % of sales
- **XL and XXL** have very low order volume — a cost-efficiency concern
- **Medium** is growing — potential upsell opportunity from Small

### 🏆 Best & Worst Performers

- **Thai Chicken Pizza** — highest revenue generator
- **Classic Deluxe Pizza** — most frequently ordered (customer favorite)
- **The Brie Carre Pizza** — consistently bottom in revenue, quantity AND orders — prime removal candidate
- **Top 5 pizzas generate disproportionately more revenue** — classic 80/20 pattern

---

## 📈 Business Value Delivered

| Business Decision | Data-Driven Recommendation |
|-------------------|-----------------------------|
| 🗑️ **Menu Optimization** | Remove Brie Carre and other bottom-5 performers — reduce waste |
| 👨‍🍳 **Staffing Strategy** | Schedule more staff on Fri/Thu — reduce staffing on Sundays |
| 📢 **Marketing Focus** | Promote Thai Chicken and Classic Deluxe — proven bestsellers |
| 📦 **Inventory Planning** | Stock more Large size ingredients — #1 customer preference |
| 💰 **Revenue Growth** | Upsell Medium customers to Large — clear size upgrade path |
| 📅 **Seasonal Planning** | Run promotions in slow months (Oct/Nov) to match July peaks |

**Projected outcome:** Implementing these recommendations targets a **10% revenue growth** through menu optimization, better staffing, and focused marketing.

---

## 📁 Project Structure

```
Pizza-Sales-Analysis-Project/
│
├── data/
│   └── pizza_sales.csv               # Raw dataset (48,000+ records)
│
├── sql/
│   └── Pizza_Sales_SQL_Queries.sql   # All SQL queries (KPIs, trends, rankings)
│
├── powerbi/
│   └── Pizza_Sales_Dashboard.pbix    # Interactive Power BI dashboard
│
├── images/
│   ├── home_dashboard.png            # Page 1 screenshot
│   └── best_worst_dashboard.png      # Page 2 screenshot
│
└── README.md
```

---

## 🚀 How to Run This Project

### SQL Analysis
1. Open **SQL Server Management Studio (SSMS)**
2. Create a new database: `pizza_sales_db`
3. Import `data/pizza_sales.csv` using the Import Wizard
4. Run all queries from `sql/Pizza_Sales_SQL_Queries.sql`

### Power BI Dashboard
1. Open **Power BI Desktop** (free download at microsoft.com/powerbi)
2. Open `powerbi/Pizza_Sales_Dashboard.pbix`
3. Update the SQL Server connection to point to your local `pizza_sales_db`
4. Click **Refresh** — all visuals update automatically
5. Use the **Page 1 / Page 2** tabs and slicers to explore

---

## 🧠 Key Technical Skills Demonstrated

```
✅  SQL Server — database creation, data import, complex queries
✅  SQL Joins & Aggregations — connecting order details to categories
✅  SQL Date Functions — DATENAME, DATEPART for trend extraction
✅  SQL Ranking Logic — TOP N queries for best/worst performer analysis
✅  SQL Business Logic — % contribution calculations, KPI formulas
✅  Power BI — 2-page interactive dashboard with slicers and filters
✅  DAX Measures — dynamic KPI cards and calculated measures
✅  Data Validation — cross-checking SQL results vs Power BI outputs
✅  Business Storytelling — translating numbers into clear recommendations
```

---

## 🌟 Final Summary

| 🔴 Problem | 🟢 My Solution | 📈 Result |
|-----------|---------------|----------|
| 48,000+ records with no insights | SQL queries extracting every KPI | Clear, accurate business metrics |
| No visibility into peak hours/days | Daily & monthly trend analysis | Optimized staffing schedule |
| Menu bloat — too many underperformers | Best/Worst seller ranking system | Data-backed menu cuts identified |
| No dashboard for management | 2-page interactive Power BI report | Self-service insights for leadership |
| Guesswork-based decisions | SQL + Power BI end-to-end pipeline | 10% projected revenue growth |

---

## 👨‍💻 About Me

I'm a data analyst passionate about turning raw transactional data into clear, profitable business insights using industry-standard tools.

- 🔗 **LinkedIn:** [Add your LinkedIn URL here]
- 📧 **Email:** Add your email here
- 🌐 **GitHub:** [github.com/PatlaveetiJabeer786](https://github.com/PatlaveetiJabeer786)

---

<div align="center">

⭐ **If this project helped you, please give it a Star!** ⭐

</div>

[![Footer](https://capsule-render.vercel.app/api?type=waving&color=0:FF6B35,100:F7C59F&height=100&section=footer)](https://github.com/PatlaveetiJabeer786/Pizza-sales-Analysis-Project)
