# 🛒 Olist-Delivery-Performance-Analysis

## 🚚 Project Description

This project analyzes **Olist’s e-commerce delivery operations** to uncover the main factors causing delivery delays and their impact on customer satisfaction.  
It also includes a **predictive model** to identify orders likely to be delayed, helping Olist take proactive action to improve delivery reliability.

---

### 🔍 Objectives

- Build a **master dataset** using SQL by merging multiple Olist tables from Kaggle.
- Analyze patterns related to:
  - 📦 **Delivery delays**
  - 💳 **Payment methods**
  - 🕒 **Order timelines and seasonality**
  - 🌎 **Regional and seller performance**
- Conduct hypothesis testing:
  - T-Test: Difference in review scores between delayed vs. on-time orders.
  - Chi-Square: Association between payment type and delivery delay.
  - ANOVA: Difference in average delay across customer states.
- Train an **XGBoost classification model** to predict whether an order will be delayed.

---

### 🎯 Outcome

The analysis and model insights aim to:

- Reduce overall **delivery delays by 30–40%** through data-driven operational improvements.
- Improve **average review scores by +1 point** by managing customer expectations and proactive communication.
- Identify **high-risk orders before dispatch** using predictive analytics.
- Provide strategic insights to enhance **customer retention and logistics efficiency**.

---

### 🧠 Predictive Model Summary

- **Algorithm:** XGBoost Classifier (with RandomOverSampler for class balancing)  
- **Key Features:** `price`, `freight_value`, `payment_value`, `payment_type`, `product_category_name_english`, `customer_state`, `seller_state`  
- **Performance Metrics:**
  - Accuracy: **0.79**
  - ROC-AUC: **0.68**
  - Recall (Delayed): **0.42**
  - Precision (Delayed): **0.14**
- **Business Use:** Detects nearly half of all delayed orders before they occur — enabling early intervention by operations teams.

---

### 💡 Business Recommendations

1. **Strengthen Carrier Performance**
   - Enforce stricter SLAs and track on-time KPIs by carrier.
   - **Impact:** Reduce delivery delays by 30–40%.

2. **Focus on High-Delay Regions (Amazonas & Maranhão)**
   - Create regional hubs or partner with local couriers.
   - **Impact:** Cut regional delay rates by up to 50%.

3. **Enhance Customer Retention & Experience**
   - Introduce loyalty rewards and proactive delay notifications.
   - **Impact:** Boost review scores by +1 and repeat purchases by 10–15%.

4. **Optimize Seller & Category Operations**
   - Improve logistics for high-volume sellers and top-selling categories.
   - **Impact:** Reduce category-related delays by 20–25%.

5. **Leverage Predictive Analytics for Delay Prevention**
   - Use model risk scores to prioritize shipments and improve ETA accuracy.
   - **Impact:** Prevent up to 25% of potential delays before dispatch.

---

### 🧩 Tech Stack

- **Languages:** Python, SQL  
- **Libraries:** pandas, numpy, scikit-learn, XGBoost, imbalanced-learn, joblib, matplotlib, seaborn  
- **Environment:** Jupyter Notebook  
- **Data Source:** Kaggle — [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/olistbr/brazilian-ecommerce)

---

### 🧾 Project Workflow

1. **Data Preparation (SQL & Python)**
   - Combine multiple raw datasets into a master dataset (`olist_master.csv`).
2. **Exploratory Data Analysis (EDA)**
   - Identify key delay patterns by time, region, payment, and category.
3. **Statistical Hypothesis Testing**
   - Validate relationships between delivery performance and customer satisfaction.
4. **Model Training**
   - Build and evaluate XGBoost classification pipeline.
5. **Business Insights & Recommendations**
   - Translate analytical results into actionable strategies.

---

### 📈 Key Insights

- 93.5% of orders are on-time; only 6.5% are delayed — yet delays significantly drop review scores (from 4.25 → 2.26).  
- 89% of delays are **carrier-related**, making logistics the top priority.  
- **Amazonas (33%)** and **Maranhão (18%)** have the worst delay rates.  
- Most orders (<200 BRL) show a **price-sensitive customer base**.  
- **Repeat customers only 13.3%** → retention opportunities exist.  

---
