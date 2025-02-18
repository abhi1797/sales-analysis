# 🛒 Sales Data Analysis - PostgreSQL Insights

## 📖 Overview
This project analyzes transactional sales data using PostgreSQL. It includes SQL scripts for revenue trends, customer segmentation, shipping cost impact, and product performance.

## 📂 Project Structure
```
 ├── 📜 README.md             # Project Documentation 
 ├── 📜 sales_analysis.sql     # SQL Queries for Insights  
```

## 📊 Key Insights from the Analysis

### 1️⃣ Regional Revenue Analysis
- **South** region leads in sales with **₹3.2 billion** and **188,757 transactions**.
- High average transaction value (**₹17,039.79 per order**) indicates premium product purchases.

### 2️⃣ Revenue by Age Group
| Age Group | Total Transactions | Total Revenue (₹) |
|-----------|--------------------|--------------------|
| 46-60     | 168,833            | 2,725,890,216.67  |
| 60+       | 110,116            | 2,483,184,701.24  |
| 26-35     | 79,001             | 1,791,131,581.70  |
| 36-45     | 79,103             | 1,780,329,661.52  |
| 18-25     | 62,947             | 1,422,126,799.06  |

📌 **Older customers (46+) generate the most revenue, indicating high-value spending in this group.**

### 3️⃣ Shipping Cost Impact on Sales
| Shipping Cost Bracket | Total Transactions | Total Revenue (₹) |
|----------------------|-------------------|-------------------|
| Low                  | High              | Moderate         |
| Medium               | Moderate          | Balanced         |
| High                 | Low               | Highest          |

📌 **Customers paying high shipping costs tend to purchase high-ticket items, while most transactions occur in the Low shipping bracket.**

## 🛠 Setup & Usage

### 📌 Requirements
- PostgreSQL 

### 📌 Running the SQL Scripts
Clone the repository:
```sh
git clone https://github.com/your-username/sales-analysis.git   
```

Open **pgAdmin** or **psql** and run the scripts:
```sql
\i Transaction_data.sql
```


---
📌 **Author:** [Abhijit Sarkar]  
📧 **Contact:** abhijit.devops17@gmail.com  
📍 **GitHub Repo:** [GitHub Repository Link](https://github.com/abhi1797/sales-analysis)
