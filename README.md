# 📊 E-Commerce Product Analytics | SQL + Power BI Project

## 🚀 Project Overview

This project analyzes large-scale e-commerce behavioral data (~100M+ events) to uncover key business insights across customer behavior, conversion funnels, product performance, and revenue trends.

The objective is to simulate a real-world analytics workflow used in product and growth teams to identify revenue leakage, improve conversion rates, and optimize customer retention.

---

## 🎯 Business Problem

E-commerce platforms face significant challenges in:

* High cart abandonment rates
* Low conversion efficiency
* Uneven product/category performance
* Poor customer retention

This project answers:

* Where is revenue leaking in the funnel?
* Which customers drive the most value?
* Which products and categories perform best?
* How does user behavior impact conversion?

---

## 🛠️ Tech Stack

* **SQL (MySQL)** — Data transformation & analytics
* **Power BI** — Dashboard & visualization
* **Python (Pandas)** — Data preprocessing
* **HTML + Chart.js** — Interactive dashboard

---

## 📂 Dataset

* Source: E-commerce clickstream dataset
* Size: ~100M+ events
Due to the high volume of event-level data, a stratified sampling approach was implemented to create a representative dataset while preserving event distribution (view, cart, purchase). This ensured efficient query performance without compromising analytical accuracy.

* Data includes:
  * User sessions
  * Product views
  * Cart events
  * Purchases

---

## 🧱 Data Pipeline

```text
Raw Events → Data Cleaning → Analytical Views → KPI Layer → Dashboard
```

Steps:

1. Cleaned raw clickstream data
2. Created reusable SQL views
3. Built KPI layer (revenue, conversion, retention)
4. Performed advanced analytics
5. Visualized insights in Power BI

---

## 📊 Key Analytics Performed

### 1. Funnel Analysis

* View → Cart → Purchase conversion
* Cart abandonment identification

### 2. Product & Category Performance

* Top revenue-generating products
* Category-level conversion analysis

### 3. Customer Analytics

* RFM segmentation
* Repeat purchase behavior
* Customer lifetime value

### 4. Revenue Analysis

* Daily revenue trends
* Growth analysis
* Peak activity periods

### 5. Advanced Analytics

* Cohort retention analysis
* Pareto (top 20% customers)
* Session behavior analysis

---

## 📈 Key Insights

* ~70% cart abandonment identified as major revenue leakage
* Top 20% customers contribute ~80% of total revenue
* Significant drop-off observed between cart and purchase stage
* Specific categories show high traffic but low conversion

---

## 📊 Dashboard

### Power BI Dashboard

* Executive KPI overview
* Funnel analysis
* Product/category performance
* Customer segmentation
* Revenue trends

#### Dashboard Preview

! [Executive Dashboard] (images/overview.png)
! [Funnel Analysis] (images/funnel.png)

#### Download Full Dashboard

Due to file size limitations, download the dashboard here: 
👉 https://drive.google.com/file/d/1CcyOMvv9VQosk5CwDSBHSbEGOwbustH2/view?usp=drive_link

### HTML Interactive Dashboard

Custom-built dashboard using Chart.js to simulate product analytics UI.

---

## 📁 Project Structure

```text
sql/ → SQL queries and analysis  
dashboard/ → Power BI & HTML dashboards  
data/ → Sample dataset  
images/ → Dashboard screenshots  
```

---

## 🧠 Business Recommendations

* Optimize checkout flow to reduce cart abandonment
* Target high-value customer segments using RFM
* Improve conversion for high-traffic categories
* Prioritize top-performing products in marketing

---

## 💡 What This Project Demonstrates

* Strong SQL (CTEs, window functions, analytical queries)
* End-to-end analytics pipeline design
* Product & business thinking
* Data-driven decision making
* Dashboarding and storytelling

---

## 🔗 Author

**Viknesh Subramanian**
Data Analyst | SQL | Power BI | Product Analytics

* GitHub: https://github.com/Viknesh-Data
* LinkedIn: https://www.linkedin.com/in/viknesh-subramanian-8-
