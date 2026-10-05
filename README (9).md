# ☀️ Solar Energy Installation & Performance Analysis | Power BI Dashboard

An interactive **Power BI dashboard** analyzing solar panel installation and performance data — covering installation trends, capacity, energy generation, vendor performance, and government subsidies — built to help stakeholders track solar adoption and evaluate cost-effectiveness.

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Business Problem](#-business-problem)
- [Dataset](#-dataset)
- [Tools & Technologies](#-tools--technologies)
- [Dashboard Preview](#-dashboard-preview)
- [Key Insights](#-key-insights)
- [Dashboard Features](#-dashboard-features)
- [Project Structure](#-project-structure)
- [How to Use](#-how-to-use)
- [Key Metrics (KPIs)](#-key-metrics-kpis)
- [Future Improvements](#-future-improvements)
- [Contact](#-contact)

---

## 📖 Overview

This project presents an end-to-end **Solar Installation & Performance Analysis** built in Power BI. It transforms raw solar installation data into an interactive dashboard that tracks installation volume, installed capacity, energy generation, vendor and panel-type performance, and subsidy utilization — enabling faster, data-driven decisions for solar program planning and cost analysis.

The report is filterable by **Year, State, City, Vendor, Category, Panel Type, and Capacity**, allowing users to drill down into the specific slice of data that matters to them.

## ❓ Business Problem

Solar rollout programs generate large volumes of installation data, but without proper visualization, it's difficult to answer key questions such as:

- Which states and cities are leading in solar adoption?
- How does installed capacity and energy generation trend over time?
- Which vendors and panel types are most commonly installed, and how do they compare?
- How much of the installation cost is offset by state and central government subsidies?
- Which installation categories (Residential / Commercial / Industrial) contribute the most capacity?

This dashboard consolidates all of that into a single, easy-to-navigate report.

## 🗃 Dataset

- **Source:** Solar panel installation dataset
- **Granularity:** Installation-level transactional data
- **Key fields:** Installation ID, Installation Date, State, City, Category, Panel Type, Vendor, Capacity (Kw), Monthly Generation Units, Cost per Kw, State Subsidy, Central Subsidy

> Note: Raw data has been cleaned and modeled prior to visualization (data cleaning performed in Excel/Python/MySQL as part of the ETL process).

## 🛠 Tools & Technologies

| Tool | Purpose |
|------|---------|
| **Power BI** | Data modeling, DAX measures, interactive dashboard design |
| **MySQL** | Data extraction, cleaning, and aggregation |
| **Excel** | Initial data exploration and validation |
| **Python (Pandas)** | Data preprocessing and cleaning |

## 🖼 Dashboard Preview

### Page 1 — Installation Overview
KPI cards (Total Installations, Total Capacity, Avg. Cost per Kw, Subsidies), installations and capacity by state, top 5 cities by installations, and monthly generation trend.

![Page 1 - Installation Overview](<img width="1312" height="742" alt="page1_overview" src="https://github.com/user-attachments/assets/bf13358b-024f-449b-bff2-93d9f8d9207d" />
)

### Page 2 — Vendor & Panel Performance
Installations by vendor, generation by panel type, installations by category, and cost/subsidy breakdown.

![Page 2 - Vendor & Panel Performance](<img width="1317" height="740" alt="page2_overview" src="https://github.com/user-attachments/assets/24dd2a6c-feb6-48d3-a0c8-3875a119f99c" />
)

## 💡 Key Insights

- **[Rajasthan]** leads in solar adoption with **[972]** installations and **[3.8K] Kw** of total installed capacity.
- **[Bifacial_Mono_Perc]** panels account for the largest share of total energy generation at **[709K]** units.
- **[Tata_Power_Solar]** is the top-performing vendor by installation count, completing **[394]** installations.
- Government subsidies (state + central combined) offset roughly **[5.65%]%** of total installation cost on average.
- **[Residential]** installations contribute the most to total capacity, followed by **[Residential]** and **[Housing_Society]**.

## ⚙️ Dashboard Features

- 📊 **Two interconnected report pages** with seamless navigation
- 🔎 **Dynamic slicers**: Year, State, City, Vendor, Category, Panel Type, and Capacity
- 📈 **KPI cards**: Total Installations, Total Capacity, Average Cost per Kw, Total Subsidies, Net Cost
- 📉 **Trend line charts** for yearly and monthly generation performance
- 🥧 **Pie chart** for generation share by panel type
- 📶 **Bar/column charts** for installations and capacity by state, city, and vendor
- 🏆 **Top 5 cities ranking** by number of installations

## 📁 Project Structure

```
Solar-Energy-Project/
│
├── Solar_Energy_Project.pbix                  # Power BI dashboard file
├── Solar_Energy_Project_SQL_Practice.sql      # MySQL schema, sample data & practice queries
├── README.md                                  # Project documentation
└── screenshots/
    ├── page1_overview.png                     # Page 1 preview
    └── page2_performance.png                  # Page 2 preview
```

## 🚀 How to Use

1. Clone or download this repository.
2. Open `Solar_Energy_Project.pbix` in **Power BI Desktop** (free download from Microsoft).
3. Use the slicers (Year, State, City, Vendor, Category, Panel Type, Capacity) to explore the data.
4. Run `Solar_Energy_Project_SQL_Practice.sql` in **MySQL** to explore the underlying data model with SQL.

## 📊 Key Metrics (KPIs)

| Metric | Value |
|--------|-------|
| Total Installations | [9441] |
| Total Capacity (Kw) | [36.96K] |
| Average Cost per Kw | ₹[1.52M] |
| Total Subsidies | ₹[809M] |
| Net Cost (after subsidy) | ₹[14Bn] |

## 🔮 Future Improvements

- Integrate a live MySQL database connection for real-time data refresh
- Add predictive generation forecasting using Python (e.g., ARIMA or Prophet)
- Include a payback-period / ROI analysis page
- Add weather/irradiance data to correlate generation with sunlight availability

## 📬 Contact

**[Sarthak Gedam]**
📧 [sarthakgedam38@gmail.com]
🔗 [LinkedIn](https://linkedin.com/in/your-profile) | [GitHub](https://github.com/your-username)

---
⭐ If you found this project useful, consider giving it a star on GitHub!
