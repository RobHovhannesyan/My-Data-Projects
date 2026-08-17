# Movie Industry Correlation Analysis 🎬📊

A Data Analytics project exploring the relationship between movie attributes (e.g., budget, votes, company) and revenue/gross earnings using Python.

## 📌 Project Overview
The main goal of this project is to clean, transform, and analyze a dataset of movies to discover which features have the strongest correlation with a movie's financial success (Gross Earnings).

## 🧰 Tools & Technologies
* **Language:** Python
* **Environment:** Jupyter Notebook / JupyterLab
* **Libraries:** 
  * `pandas` & `numpy` (Data Cleaning & Manipulation)
  * `matplotlib` & `seaborn` (Data Visualization)

## 🧹 Key Data Cleaning & Feature Engineering Steps
* **Handling Data Types:** Converted columns like `budget`, `gross`, `votes`, and `runtime` into correct numeric types.
* **Date Parsing & Extracting:** Extracted the 4-digit release year from dirty string values in the `released` column using Regex (`r'(\d{4})'`).
* **Categorical Encoding:** Applied Categorical Encoding (`.cat.codes`) to text attributes (such as `company`, `genre`, `director`, `writer`) to include them in numerical correlation matrices.

## 📊 Key Findings & Insights
1. **High Correlation with Gross Revenue:**
   * **Votes vs. Gross:** Strongly correlated. Movies with higher audience engagement and vote counts generate significantly higher earnings.
   * **Budget vs. Gross:** Positive correlation. Higher production budgets generally lead to higher gross revenue.
2. **Low Correlation:**
   * Features like `company`, `director`, and `writer` showed minimal direct numerical correlation with global gross revenue compared to budget and popularity metrics.

## 🚀 How to Run
1. Clone this repository:
   ```bash
   git clone [https://github.com/your-username/movie-correlation-project.git](https://github.com/your-username/movie-correlation-project.git)
