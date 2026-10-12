CREATE database IF NOT exists HR_Emp_Attrition;

USE HR_Emp_Attrition;

SELECT * FROM HR_Employees; 

-- 1
SELECT * FROM HR_Employees LIMIT 10;

-- 2
SELECT COUNT(*) AS TotalEmployees FROM HR_Employees;

-- 3
SELECT DISTINCT Department FROM HR_Employees ORDER BY Department;

-- 4
SELECT Attrition, COUNT(*) AS EmployeeCount
FROM HR_Employees GROUP BY Attrition;

-- 5
SELECT EmployeeNumber, JobRole, Department, OverTime
FROM HR_Employees WHERE OverTime = 'Yes'
ORDER BY EmployeeNumber;

-- 6
SELECT AVG(MonthlyIncome) AS AverageMonthlyIncome FROM HR_Employees;

-- 7
SELECT * FROM HR_Employees WHERE NumCompaniesWorked IS NULL;

-- 8
SELECT * FROM HR_Employees
WHERE MonthlyIncome = (SELECT MAX(MonthlyIncome) FROM HR_Employees);

-- 9
SELECT Gender, COUNT(*) AS EmployeeCount
FROM HR_Employees GROUP BY Gender;

-- 10
SELECT * FROM HR_Employees WHERE YearsAtCompany = 0;

-- 11
SELECT Department,
       COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Leavers,
       100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) / COUNT(*) AS AttritionRatePct
FROM HR_Employees
GROUP BY Department;

-- 12
SELECT EmployeeNumber, JobRole, Department, TotalWorkingYears, MonthlyIncome
FROM HR_Employees ORDER BY TotalWorkingYears DESC LIMIT 10;

-- 13
SELECT CASE
         WHEN YearsAtCompany < 1 THEN '<1yr'
         WHEN YearsAtCompany BETWEEN 1 AND 3 THEN '1–3yr'
         WHEN YearsAtCompany BETWEEN 4 AND 6 THEN '4–6yr'
         ELSE '7+yr'
       END AS TenureCategory,
       COUNT(*) AS EmployeeCount
FROM HR_Employees
GROUP BY TenureCategory
ORDER BY CASE TenureCategory
           WHEN '<1yr' THEN 1 WHEN '1–3yr' THEN 2
           WHEN '4–6yr' THEN 3 ELSE 4 END;

-- 14
SELECT JobLevel, Attrition, AVG(MonthlyIncome) AS AverageMonthlyIncome
FROM HR_Employees GROUP BY JobLevel, Attrition
ORDER BY JobLevel, Attrition;

-- 15
SELECT JobRole, COUNT(*) AS Leavers
FROM HR_Employees WHERE Attrition='Yes'
GROUP BY JobRole ORDER BY Leavers DESC LIMIT 5;

-- 16
SELECT * FROM HR_Employees
WHERE Attrition='Yes' AND YearsAtCompany < 1;

-- 17
SELECT EmployeeNumber, MonthlyIncome, PercentSalaryHike,
       MonthlyIncome * (1 + PercentSalaryHike / 100.0) AS NewMonthlyCompensation
FROM HR_Employees;

-- 18
SELECT OverTime, Attrition, COUNT(*) AS EmployeeCount
FROM HR_Employees GROUP BY OverTime, Attrition;

-- 19
SELECT EmployeeNumber, JobRole, TrainingTimesLastYear, Department
FROM HR_Employees ORDER BY TrainingTimesLastYear DESC LIMIT 10;

-- 20
SELECT EmployeeNumber, JobRole, TotalWorkingYears,
       RANK() OVER (ORDER BY TotalWorkingYears DESC) AS ExperienceRank
FROM HR_Employees
ORDER BY ExperienceRank, EmployeeNumber;

-- 21
-- NTILE-style top quartile within each department.
WITH ranked AS (
  SELECT *,
         NTILE(4) OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS quartile
  FROM HR_Employees
)
SELECT EmployeeNumber, Department, JobRole, MonthlyIncome
FROM ranked
WHERE quartile = 1
ORDER BY Department, MonthlyIncome DESC;

-- 22
WITH deciles AS (
  SELECT *,
         NTILE(10) OVER (ORDER BY MonthlyIncome) AS IncomeDecile
  FROM HR_Employees
)
SELECT IncomeDecile,
       COUNT(*) AS EmployeeCount,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Leavers,
       100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) / COUNT(*) AS AttritionRatePct
FROM deciles
GROUP BY IncomeDecile
ORDER BY IncomeDecile;

-- 23
-- Assumption: 2 points each for tenure <=1 year, performance <=3,
-- overtime = Yes, and work-life balance <=2. Maximum score = 8.
WITH scored AS (
  SELECT *,
         (CASE WHEN YearsAtCompany <= 1 THEN 2 ELSE 0 END +
          CASE WHEN PerformanceRating <= 3 THEN 2 ELSE 0 END +
          CASE WHEN OverTime = 'Yes' THEN 2 ELSE 0 END +
          CASE WHEN WorkLifeBalance <= 2 THEN 2 ELSE 0 END) AS RiskScore
  FROM HR_Employees
)
SELECT EmployeeNumber, JobRole, Department, YearsAtCompany,
       PerformanceRating, OverTime, WorkLifeBalance, RiskScore
FROM scored
ORDER BY RiskScore DESC, YearsAtCompany ASC, EmployeeNumber
LIMIT 50;

-- 24
SELECT Department, JobLevel,
       COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Leavers,
       100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) / COUNT(*) AS AttritionRatePct,
       AVG(MonthlyIncome) AS AverageMonthlyIncome
FROM HR_Employees
GROUP BY Department, JobLevel
ORDER BY Department, JobLevel;
