# Amazon Price Tracker & Automated Email Notifier 🛒📉

A Python-based web scraping and automation tool designed to monitor Amazon product prices and send automated email alerts when a target price threshold is reached.

---

## 📌 Project Overview

This project automates the process of tracking product prices on Amazon. It extracts product details, cleans and formats the scraped data, appends historical records to a dataset, and triggers an email notification whenever the price drops below a specified threshold.

---

## 🛠️ Tech Stack & Tools

* **Language:** Python
* **Web Scraping:** `requests`, `BeautifulSoup4`
* **Data Processing & Storage:** `pandas`, `csv`
* **Automation & Emailing:** `smtplib`, `email.mime`
* **Environment:** Jupyter Notebook / macOS

---

## ✨ Features

* **Custom HTTP Headers:** Bypasses basic anti-bot protections using tailored `User-Agent` configurations.
* **HTML Parsing & Data Cleaning:** Extracts product title and price elements, removes unwanted string characters, and converts data types for analytical readiness.
* **Historical Data Logging:** Appends clean records (Title, Price, Date) into a CSV dataset without overwriting existing data (`a+` mode).
* **Automated Email Alerts:** Integrates Gmail SMTP server (SSL/TLS encryption) to instantly alert the user when target price conditions are met.

---

## 🚀 How It Works

1. **Scrape:** Fetch Amazon product page HTML using `requests` with custom headers.
2. **Parse:** Extract raw title and price elements via `BeautifulSoup`.
3. **Clean:** Strip currency symbols/newlines and convert the price string to `float`.
4. **Log:** Append the structured record (`Title`, `Price`, `Date`) to `AmazonWerScraperDataSet.csv`.
5. **Alert:** Check if `Price < Threshold` — if true, execute `send_mail()` via Gmail SMTP.

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.
