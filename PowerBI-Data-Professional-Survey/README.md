# 📊 Data Professional Survey Analysis | Power BI Dashboard

## 📌 Project Overview
This project presents an interactive **Power BI Dashboard** analyzing survey data collected from **630+ Data Professionals** globally. The primary objective is to uncover key insights into the data industry, including salary trends, career progression difficulty, programming language preferences, and job satisfaction metrics.

The project demonstrates end-to-end data analysis capabilities: from **data cleaning and transformation** in Power Query to **data modeling, DAX measures, and dashboard visualization**.

---

## 🛠️ Tools & Technologies
* **Power BI Desktop:** Data Modeling, Power Query Transformation, DAX (Data Analysis Expressions), Visualization
* **Excel:** Primary Data Source (`Power BI - Final Project.xlsx`)
* **GitHub:** Version Control & Portfolio Presentation

---

## 🧹 Data Cleaning & Transformation Steps
Before visual creation, the dataset was cleaned and structured in Power Query:
1. **Handling Missing & Invalid Data:** Cleaned null values and standardized textual responses.
2. **Column Standardization:** Cleaned prefix tags like `Other (Please Specify):` in job titles, countries, and languages to group responses accurately.
3. **Data Type Correction:** Converted text-based numeric ratings and salaries into standardized numerical formats.
4. **Data Reduction:** Removed non-essential metadata columns (e.g., browser info, timestamps) to optimize report performance.

---

## 📈 Key Dashboard Insights & Metrics
The dashboard provides a high-level **Executive Summary** covering key data points:

* **Demographics & Industry Reach:** Analyzed 630 respondents with an average age of **29.87 years**, across key markets like the United States, Canada, the United Kingdom, and India.
* **Favorite Programming Languages:** **Python** dominates as the top language choice across all data roles, followed by **R** and **SQL**.
* **Salary Distribution:** Evaluated average salaries across job titles, showing **Data Scientists** and **Data Engineers** among the top earners.
* **Satisfaction Gauges (Scale 0-10):**
  * **Work/Life Balance:** High satisfaction score averaging **5.74 / 10**.
  * **Salary Satisfaction:** Moderate satisfaction score averaging **4.27 / 10**.
* **Career Entry Difficulty:** Highlighted that the majority of survey takers found breaking into the data domain to be **Neither Easy nor Difficult** (~42.7%) or **Difficult** (~24.8%).

---

## 📐 Key DAX Measures Used
Custom DAX measures were created to dynamically aggregate metrics:

```dax
// Total Respondents Count
Count of Survey Takers = COUNT('Data Professional Survey'[Unique ID])

// Average Age
Average Age = AVERAGE('Data Professional Survey'[Q10 - Current Age])

// Average Satisfaction Scores
Avg Work/Life Satisfaction = AVERAGE('Data Professional Survey'[Q6 - Work/Life Balance Rating])
Avg Salary Satisfaction = AVERAGE('Data Professional Survey'[Q6 - Salary Rating])
