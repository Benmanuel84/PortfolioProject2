/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [EmployeeID]
      ,[FullName]
      ,[JobTitle]
      ,[Department]
      ,[BusinessUnit]
      ,[Gender]
      ,[Ethnicity]
      ,[Country]
      ,[City]
      ,[Age]
  FROM [PortfolioProject].[dbo].[EmployeeDemographics]


  Select*
  From [PortfolioProject].[dbo].[EmployeeDemographics]
 inner join [PortfolioProject].[dbo].[EmployeeSalary]
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Order by 1,2

--Updating And Deleting Data 


-- CTEs 

WITH CTE_Employee as
(select FullName, Gender, AnnualSalary, Country,
COUNT(gender) OVER (PARTITION by gender) As TotalGender
, AVG(AnnualSalary) OVER (PARTITION By Gender) As AVGAnnualSalary
FROM PortfolioProject..EmployeeDemographics emp
Join PortfolioProject..EmployeeSalary ann
 on emp.EmployeeID = ann.EmployeeID
 )
Select*
From CTE_Employee



select * from EmployeeSalary

--Temp Tables

CREATE TABLE #temp_Employee(
EmployeeID nvarchar(100),
HireDate nvarchar(100),
AnnualSalary int,
[Bonus%] int,
ExitDate nvarchar(100),
HiredateConverted Varchar (100)
)
select *
From #temp_Employee

--Drop Table #temp_Employee;

INSERT INTO #temp_Employee
select * 
from PortfolioProject..EmployeeSalary

--subquery in select

Select EmployeeID,Avg(AnnualSalary), avg(cast(AnnualSalary as int)) as AvgAnnualSalary
from EmployeeSalary
Group by EmployeeID
Order by 2,3


 -- avgsalary

 Select Jobtitle, Count(JobTitle) as Total_perJob, Avg(Age) as AvgAge, Avg(Annualsalary) As AvgSalary
 from PortfolioProject..EmployeeDemographics emp
 Join PortfolioProject..EmployeeSalary sal
   on emp.EmployeeID = sal.EmployeeID
   Group by JobTitle
  -- Having count(jobtitle) > 10

-- Count

   Select Country, Count(Country) as Total_Country
 from PortfolioProject..EmployeeDemographics emp
-- Join PortfolioProject..EmployeeSalary sal
  -- on emp.EmployeeID = sal.EmployeeID
  Group by Country
   
     Select Ethnicity, Count(Ethnicity) as Total_Ethnicity
 from PortfolioProject..EmployeeDemographics emp
-- Join PortfolioProject..EmployeeSalary sal
  -- on emp.EmployeeID = sal.EmployeeID
  Group by Ethnicity


   create Table #Temp_Employee2(
   EmployeeID Varchar(100),
   FullName Varchar(100),
   JobTitle Varchar(100),
   Department Varchar(100),
   BusinessUnit Varchar(100),
   Gender Varchar(100),
   Ethnicity Varchar(100),
   Country Varchar(100),
   City Varchar(100),
   Age Int
   )

select *

   

   Insert Into #Temp_Employee2
SELECT *
FROM EmployeeDemographics



SELECT *
FROM employeeSalary


-- Looking at Total Department vs AnnualSalary

Select dem.EmployeeID, dem.FullName, dem.Country, dem.jobtitle, dem.Department, dem.department, dem.gender, sal.AnnualSalary,sal.[Bonus%]
From PortfolioProject..EmployeeDemographics dem
Join PortfolioProject..EmployeeSalary sal
on dem.EmployeeID = sal.EmployeeID
Where Department Is not Null
Order by 1,2,3

Select dem.EmployeeID, dem.Fullname, dem.JobTitle, sal.Annualsalary, sal.[Bonus%]
From PortfolioProject..EmployeeDemographics dem
Join PortfolioProject..EmployeeSalary sal
   on dem.EmployeeID = sal.EmployeeID
Where [Bonus%] >0
-- and FullName = 'Claire Vazqez'
Order by 1,2,3

-- standardize Date format

Select HireDateConverted, Convert(date, HireDate)
from EmployeeSalary

Update EmployeeSalary
set HireDate = CONVERT(date, Hiredate)

Alter Table EmployeeSalary
Add HiredateConverted Date;

UPDATE EmployeeSalary
set HireDateConverted = CONVERT(date,Hiredate)

Select*
from #Temp_Employee2