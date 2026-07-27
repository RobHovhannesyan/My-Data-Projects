# World Layoffs: Data Cleaning & Exploratory Data Analysis (EDA)

## Project Overview
This project demonstrates a complete data analytics workflow using SQL. It is divided into two distinct phases: first, cleaning and standardizing a raw dataset of global company layoffs, and second, analyzing the refined data to discover macroeconomic trends and insights.

## Tech Stack
- Database Management System: MySQL
- Environment: JetBrains DataGrip

---

## Phase 1: Data Cleaning (1_data_cleaning.sql)
In the initial phase, the raw dataset was prepared for analysis by executing four core data-cleaning steps:

### 1. Remove Duplicates
Duplicate records were identified and deleted to ensure each layoff event is counted only once. This was achieved by using the ROW_NUMBER() OVER() window function inside a Common Table Expression (CTE).

### 2. Standardize the Data
Data formatting inconsistencies were resolved across the dataset by:
- Trimming accidental leading and trailing whitespaces from text fields.
- Converting text-formatted dates into proper MySQL DATE types using the STR_TO_DATE() function.
- Standardizing and grouping variations of industry names for consistency.

### 3. Handle Null Values or Blank Values
Columns containing numerical data, such as total_laid_off, percentage_laid_off, and funds_raised_millions, were cleaned. Occurrences where empty cells were incorrectly imported as the literal text string 'NULL' or left entirely blank were converted into true database NULL values. Missing data was also populated where logical matches existed in the dataset.

### 4. Remove Any Unnecessary Columns
Rows and columns that lacked critical information—such as records where both total_laid_off and percentage_laid_off were missing—were dropped. This optimized the table structure, making it clean and performant for business queries.

---

## Phase 2: Exploratory Data Analysis (2_exploratory_analysis.sql)
Once a reliable database structure was established, advanced queries were executed to extract business and economic insights:

- Temporal Trends: Layoffs were aggregated by year and month to pinpoint when the downsizing trend peaked globally.
- Rolling Totals: A window function (`SUM() OVER()`) was used to calculate the cumulative, rolling total of layoffs month-over-month to visualize the compounding scale of job losses.
- Top 5 Yearly Rankings: Multiple chained CTEs were combined with the DENSE_RANK() function to isolate and rank the top 5 companies with the highest layoffs within each individual calendar year.

### Featured SQL Snippet (Yearly Top 5 Companies):
```sql
WITH Company_Year (company, years, total_laid_off) AS (
    SELECT company, YEAR(`date`), SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS (
    SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Rank_s
    FROM Company_Year
    WHERE years IS NOT NULL
)
SELECT * FROM Company_Year_Rank 
WHERE Rank_s <= 5;
