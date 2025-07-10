# ⚡ Monthly Power Generation Analysis – Uttar Pradesh

**Duration:** December 2024 – January 2025  
**Tools Used:** Python, Pandas, Matplotlib, Statsmodels

---

## 📊 Project Overview

This project analyzes monthly power generation data from the Indian state of **Uttar Pradesh** over a 10-year period (2008–2017). The aim is to detect **long-term trends**, uncover **seasonal patterns**, and generate **forecasts** using classical time series techniques.

---

## 📁 Dataset Description

- **Source:** Ministry of Power, Government of India  
- **Hosted on:** National Data & Analytics Platform (NDAP)  
- **Timeframe:** January 2008 to March 2017  
- **Frequency:** Monthly  
- **Type:** Univariate time series (Total power generation in MW)

---

## 🔍 Why This Dataset?

- **Rich Time-Series Scope:** Covers nearly a decade of monthly data—ideal for time series modeling.
- **Seasonality:** Power usage varies with climate, industrial demand, and public policies.
- **Policy-Relevant:** Insights from this dataset can support decision-making in the **energy** and **public infrastructure** sectors.
- **Model Testing Ground:** Excellent for applying and comparing time series methods like **STL**, **ARIMA**, and **stationarity tests**.

---

## ⚙️ Methods & Analysis

- **STL Decomposition:** Separated trend, seasonality, and residual components  
- **ADF Test:** Checked for stationarity and ensured model assumptions  
- **ARIMA Modeling:** Built ARIMA models for forecasting future power output  
- **Visualization:** Time series plots, seasonal decomposition, and forecast projections

---

## 🧰 Tools & Libraries

- `pandas` – data manipulation  
- `matplotlib`, `seaborn` – visualization  
- `statsmodels` – ADF test, ARIMA modeling  
- `scipy` – statistical testing  
- `datetime` – time parsing

---

## ✅ Key Outcomes

- Discovered an **upward trend** in overall power generation post-2012  
- Identified **seasonal dips** during monsoon months and peaks during summer  
- Forecasts showed expected rise in demand in subsequent years  
- Validated ARIMA model through residual diagnostics and accuracy checks

---

## 📂 Repository Structure

