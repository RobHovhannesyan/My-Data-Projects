# 🦠 COVID-19 Data Exploration (SQL Project)

Welcome to the **COVID-19 Data Exploration** repository. This project focuses on analyzing global COVID-19 data using **MS SQL Server**. The analysis explores infection rates, death percentages, global statistics, and vaccination rollouts across different countries and continents.

---

## 📌 Project Overview

The objective of this project is to clean, transform, and explore large-scale COVID-19 datasets to uncover meaningful insights regarding the pandemic's impact worldwide.

* **Database Engine:** MS SQL Server
* **Key Metrics Analyzed:**
  * Death Percentage per Country (`Total Cases vs Total Deaths`)
  * Infection Rate relative to Population (`Total Cases vs Population`)
  * Highest Infection and Death Counts per Continent and Country
  * Global Monthly/Daily Case and Death Totals
  * Rolling Vaccination Percentage (`Total Population vs Vaccinations`)

---

## 🛠 SQL Skills & Concepts Applied

This project demonstrates advanced SQL querying techniques, including:

* **Joins:** Combining `CovidDeaths` and `CovidVaccinations` datasets on `Location` and `Date`.
* **Aggregate Functions:** `SUM()`, `MAX()`, `COUNT()`.
* **Data Type Conversions:** `CAST()`, `CONVERT()`.
* **Window Functions:** `SUM(...) OVER (Partition by ... Order by ...)` for calculating rolling vaccination totals.
* **Common Table Expressions (CTEs):** Simplifying complex queries for rolling calculation ratios.
* **Temporary Tables (`#TempTables`):** Storing intermediate data for modular and efficient performance.
* **Views:** Creating persistent views to support downstream BI tools (Power BI / Tableau).

---

## 📊 Key Queries & Exploration Breakdown

### 1. Total Cases vs Total Deaths
Calculates the likelihood of dying if infected with COVID-19 in a specific country.
```sql
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%states%'
and continent is not null
order by 1,2;
