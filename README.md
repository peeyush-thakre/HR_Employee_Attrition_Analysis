# HR Employee Attrition Analysis

**Author:** Peeyush Thakre  
**Project type:** HR Analytics / Exploratory Data Analysis / Business Intelligence

## Project Overview

This project analyzes employee attrition using Python, SQL, and Power BI. It combines exploratory data analysis in a Jupyter Notebook, SQL queries for HR reporting, a CSV dataset, and a Power BI report.

The goal is to understand where attrition is concentrated and explore how attrition varies with department, job role, overtime, job satisfaction, monthly income, age, tenure, job level, gender, and distance from home.

## Project Files

| File | Purpose |
|---|---|
| `EDA.ipynb` | Python exploratory data analysis, data-quality checks, charts, bivariate and multivariate analysis, and written insights |
| `HR_Employee_Attrition.csv` | Employee-level source dataset used by the notebook |
| `HR-Employee-Attrition.sql` | MySQL database setup statement and 24 HR analysis queries |
| `HR_emp_attrition.pbix` | Power BI report file for interactive dashboard exploration |
| `README.md` | Project documentation |
| `requirements.txt` | Python package dependencies for the notebook |

## Dataset Overview

The CSV contains **1,470 rows and 35 columns**. The notebook's data inspection reports no missing values and no duplicate rows in the supplied CSV.

Important fields include:

- `Attrition` — whether the employee left (`Yes`/`No`)
- `Department`, `JobRole`, `JobLevel`
- `Age`, `Gender`, `MaritalStatus`, `EducationField`
- `OverTime`, `BusinessTravel`, `DistanceFromHome`
- `JobSatisfaction`, `EnvironmentSatisfaction`, `WorkLifeBalance`
- `MonthlyIncome`, `PercentSalaryHike`
- `TotalWorkingYears`, `YearsAtCompany`, `YearsInCurrentRole`
- `PerformanceRating`, `TrainingTimesLastYear`

## Analysis Workflow

### 1. Python EDA (`EDA.ipynb`)

The notebook covers:

1. Loading the CSV and reviewing the dataset.
2. Inspecting shape, columns, data types and descriptive statistics.
3. Checking missing values, duplicate rows and unique values.
4. Removing unnecessary columns in an analysis copy.
5. Examining the attrition target variable.
6. Univariate analysis of age, monthly income, job satisfaction and department.
7. Bivariate analysis of attrition against age, income, satisfaction, overtime, department, job role, gender, tenure and job level.
8. Business-focused comparisons for overtime, job role, satisfaction, income and distance from home.
9. Correlation analysis for numerical columns.
10. Calculating the overall attrition rate and comparing multiple factors, including overtime plus job satisfaction.

### 2. SQL Analysis (`HR-Employee-Attrition.sql`)

The SQL script creates/selects the `HR_Emp_Attrition` database and queries the `HR_Employees` table. The queries cover employee counts, department and gender breakdowns, overtime, income, tenure categories, leavers by job role, compensation after salary hikes, experience ranking, income quartiles/deciles, risk scoring, and department/job-level comparisons.

**Important:** The script expects a table named `HR_Employees` to exist in the selected database. It contains analysis queries, not a `CREATE TABLE` statement or CSV import routine. Import the CSV into MySQL and name the table `HR_Employees` before running the queries. Some queries use CTEs and window functions, so use **MySQL 8.0 or later**.

### 3. Power BI (`HR_emp_attrition.pbix`)

Open the PBIX file with Power BI Desktop to explore the report. The report is the interactive visualization layer; the Python notebook and SQL script are separate analysis artifacts.

If refreshing the report on another computer, you may need to reconnect the data source and update its file/database path in Power BI.

## Key Findings Documented in the EDA

The notebook's written insights report:

- **Employees:** 1,470
- **Employees who left:** 237
- **Employees retained:** 1,233
- **Overall attrition rate:** 16.12%
- **Overtime:** 30.5% attrition among employees working overtime versus 10.4% among those not working overtime.
- **Department:** Sales has the highest reported department attrition rate at 20.6%.
- **Job role:** Sales Representatives have the highest reported job-role attrition rate at 39.8%.
- **Job satisfaction:** Reported attrition is 22.8% at satisfaction level 1 and 11.3% at level 4.
- Employees who left had lower average and median monthly income and greater average and median distance from home than employees who stayed.

Use these values as the notebook's reported findings and verify them against the source data if you revise filters, calculations or the dataset.

## Setup: Python Notebook

### Prerequisites

- Python 3.10 or later recommended
- Jupyter Notebook
- The project CSV in the path expected by the notebook

### Windows

```bash
python -m venv .venv
.venv\Scripts\activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
jupyter notebook
```

Open `EDA.ipynb` and run the cells from top to bottom.

### macOS / Linux

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
jupyter notebook
```

## Setup: SQL

1. Install MySQL Server 8.0 or later and a SQL client such as MySQL Workbench.
2. Create/select the database and import `HR_Employee_Attrition.csv` into a table named `HR_Employees`.
3. Check that column names and types match the CSV fields.
4. Open `HR-Employee-Attrition(1).sql` and run the queries.

The SQL file starts with `CREATE DATABASE IF NOT EXISTS HR_Emp_Attrition;` and `USE HR_Emp_Attrition;`, then queries `HR_Employees`.

## Setup: Power BI

1. Install Power BI Desktop.
2. Open `HR_emp_attrition.pbix`.
3. If prompted, update the data source credentials or file/database location.
4. Refresh the model and verify the KPI totals against the CSV and notebook.

## Repository Structure

```text
HR-Employee-Attrition/
├── EDA.ipynb
├── HR_Employee_Attrition.csv
├── HR-Employee-Attrition.sql
├── HR_emp_attrition.pbix
├── README.md
└── requirements.txt
```

## Limitations and Responsible Interpretation

- EDA shows patterns and associations; it does not prove that a factor causes attrition.
- The dataset is a snapshot and does not itself establish the timing or reason for each departure.
- A risk score in the SQL analysis is a rule-based exploratory score, not a validated predictive model.
- Do not use an exploratory score or demographic attribute as the sole basis for employment decisions.
- Validate calculations and dashboard totals before using findings in formal HR decisions.

## Conclusion

This project demonstrates an end-to-end HR analytics workflow using Python for EDA, SQL for structured HR queries, and Power BI for interactive reporting. It highlights attrition patterns and provides a basis for further investigation into employee retention.
