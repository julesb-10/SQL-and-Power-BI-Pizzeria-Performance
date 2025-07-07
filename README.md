# Pizza Sales Analysis Dashboard (PostgreSQL + Power BI Project)

## Project Overview
This project showcases a full end-to-end data analysis workflow using PostgreSQL and Power BI.

The goal was to analyze pizza sales data and present a high-level overview of its performance. The project involved importing CSV data into a PostgreSQL database, cleaning and formatting the data, writing SQL queries to calculate KPIs and trends for validation purposes, documenting the process, and building interactive Power BI dashboards to visualize the findings.

The SQL queries were not directly used in the Power BI dashboards but were written to validate and ensure that the DAX measures in Power BI matched the expected results from the database.

---

## Tools Used
- PostgreSQL
- Power BI
- Google Docs (for documentation)

---

## Project Steps

### 1. Data Import and Cleaning
- Imported raw CSV data into PostgreSQL.
- Cleaned and formatted the data in SQL to ensure correct data types and consistency.

### 2. SQL Analysis for Validation
- Wrote SQL queries to calculate KPIs and trends for comparison against DAX measures in Power BI.
- Key metrics calculated:
  - Total Revenue
  - Average Order Value
  - Total Pizzas Sold
  - Total Orders Placed
  - Average Pizzas per Order
  - Daily Orders Trend
  - Hourly Orders Trend
  - Monthly Orders Trend
  - Percentage of Sales by Category
  - Percentage of Sales by Pizza Size
  - Total Pizzas Sold by Category
  - Top 5 Best Sellers by Total Pizzas Sold
  - Top 5 Best Sellers by Revenue
  - Bottom 5 Worst Sellers by Total Pizzas Sold
  - Bottom 5 Worst Sellers by Revenue

 
  Note: In cases where improvements or alternate approaches were identified after writing the initial queries, revised versions were provided after the originals. Additional notes were also included where relevant to explain specific query choices or observations.


### 3. Documentation
- Documented the SQL queries and their results in a separate file, including screenshots of query outputs as well as the queries themselves.

### 4. Power BI Dashboard Development
- Connected Power BI to the PostgreSQL database.
- Performed additional data cleaning and feature engineering for better reporting and filtering.
- Built two interactive dashboards:
  - **Topline Performance Dashboard:** Displays key Pizzeria KPIs to monitor sales performance and ordering behavior.
  - **Top 5 and Bottom 5 Dashboard:** Displays best and worst performing pizzas based on revenue, quantity sold, and orders placed.
- Added navigation buttons and slicers for filtering by pizza category and date range.
- Ensured all DAX measures aligned with the validated SQL results.

---

## Repository Contents
- `Pizza Store Dashboard.pbix` – Power BI dashboard file
- `Pizza Sales SQL Queries Documentation.pdf` – Documentation of SQL queries and results
- `Pizzeria Dashboards` – Folder with screenshots of the dashboards
- `README.md` – Project documentation

---

## Key Learnings
This project demonstrates how SQL and Power BI can be combined for data analysis and dashboard reporting. It highlights the process of integrating a PostgreSQL database with Power BI, validating DAX measures using SQL, and designing KPI-focused interactive dashboards.

