# Sales-Analytics-DataWarehouse


##  Project Overview
This project demonstrates how to design and implement a **modern data warehouse** using **SQL Server** and the **Medallion Architecture (Bronze, Silver, Gold layers)**.  
The workflow covers everything from **raw data ingestion** to **advanced analytics** and preparing datasets for **dashboarding and reporting**.

---

## Datasets Used
- **Customers dataset** – information about customers  
- **Products dataset** – details of products offered  
- **Sales dataset** – transactions and sales records  

---

##  Process & Architecture

###  Bronze Layer
- Acts as the **raw storage layer**  
- Data was **loaded directly** from the source with minimal transformations  

###  Silver Layer
- The **core transformation layer**  
- Applied the **ETL process** (Extract, Transform, Load)  
- Performed data cleaning, normalization, and integration between customers, products, and sales  

###  Gold Layer
- The **business-ready layer**  
- Applied **advanced transformations** based on business requirements  
- Produced **final curated datasets** for analytics, KPIs, and reporting  

---

## Analysis Performed
1. **Exploratory Data Analysis (EDA)**  
   - Checked data quality, distributions, and correlations  
   - Identified trends in sales and customer behavior  

2. **Advanced Data Analytics**  
   - Built aggregated metrics and KPIs  
   - Analyzed sales performance by region, product category, and customer segments  
   - Prepared datasets for visualization and dashboarding  

---

## Next Steps
- Create an **interactive dashboard** (e.g., Power BI / Tableau) based on the curated Gold layer datasets  
- Automate the ETL pipelines for real-time or scheduled data refreshes  

---

##  Tech Stack
- **SQL Server** – database and data warehouse  
- **ETL Process (SQL scripts & pipelines)**  
- **Medallion Architecture** (Bronze, Silver, Gold)  
- **Python / Power BI (optional)** – for EDA and visualization  

---

## Key Takeaways
- Learned how to design a **scalable data warehouse**  
- Gained experience with **data cleaning, transformation, and integration**  
- Built a strong foundation for **business intelligence (BI) dashboards**  

---
 This project shows the **end-to-end data pipeline**: from raw data ingestion to **analytics-ready datasets**.
