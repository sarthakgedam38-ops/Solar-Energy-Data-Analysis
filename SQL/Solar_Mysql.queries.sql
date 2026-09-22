create database Solar_Energy;
use Solar_Energy;	

create table Solar (
Installation_Id varchar(50),
State varchar(100),
City varchar(50),
Category varchar(50),
Capacity_Kw int,
Panel_Type varchar(50),
Vendor varchar(50),
Installation_Date date,
Gross_Cost_Rs int,
Central_Subsidy_Rs int,
State_Subsidy_Rs int,
Monthly_Generation_Units int,
Tariff_Rs_Per_Unit int,
Net_Metering_Status	varchar(100),
Year year );

ALTER TABLE Solar MODIFY Installation_Date DATE NULL;

show variables like 'local_infile';
set global local_infile = 1;

show variables like 'secure_file_priv';

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Clean_Solar.csv"
into table Solar
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows (
Installation_Id,
State,
City,
Category,
Capacity_Kw,
Panel_Type,
Vendor,
@Installation_Date,
Gross_Cost_Rs,
Central_Subsidy_Rs,
State_Subsidy_Rs,
Monthly_Generation_Units,
Tariff_Rs_Per_Unit,
Net_Metering_Status,
@Year)
set Installation_Date = nullif(@Installation_Date, ''),
Year = nullif(@Year, '');

select * from Solar;

# 1. Find the Total Installations
select count(Installation_Id) as Total_Installations
from Solar;

# 2. Find the Total Capacity KW
select sum(Capacity_Kw) as Total_Capacity
from Solar;

# 3. Find Avg Cost Per Kw
select round( avg(Gross_Cost_Rs) / 1000000,2) as Avg_Cost
from Solar;

# 4. Find the State Subsidy. 
select concat( round( sum(State_Subsidy_Rs) / 1000000,2),'M') as Total_State_Subsidy
from Solar;

# 5. Find the Central Subsidy. 
select concat(round(sum(Central_Subsidy_Rs) / 1000000,2),'M') as Total_Central_Subsidy
from Solar;

# 6. Top 5 Cities by Installations
select City, count(Installation_Id) as Total_Installations
from Solar
group by City
order by Total_Installations desc limit 5;

# 7. Total Installations by State. 
select State, count(Installation_Id) as Total_Installations
from Solar
group by State
order by Total_Installations desc;

# 8. Total Installation by Year
select year(Installation_Date) as Years, count(Installation_Id) as Total_Installations
from Solar
group by Years
order by Total_Installations desc;

# 9. Total Installation by Category
select Category, count(Installation_Id) as Total_Installations
from Solar
group by Category
order by Total_Installations desc;

# 10. No. Of Installation by Vendor. 
select Vendor, count(Installation_Id) as Total_Installations
from Solar
group by Vendor
order by Total_Installations desc;

# 11. Total Generation Panel by Units
select Panel_Type, sum(Monthly_Generation_Units) as Total_Units, concat( round(sum(Monthly_Generation_Units) * 100.0 
/ sum(sum(Monthly_Generation_Units)) over(), 2),  "%") as Unit_PCt
from Solar
group by Panel_Type
order by Total_Units desc;

# 12. Monthly Generation Units
select monthname(Installation_Date) as Months, sum(Monthly_Generation_Units) as Total_Units
from Solar
group by Months
order by Total_Units desc;

select * from Solar
where Installation_Date is null or Year is null;

# Write a query to find all installations in the state of 'Rajasthan' with a Capacity_Kw greater than 5.
# showing Installation_Id, City, Capacity_Kw, and Vendor, sorted by Capacity_Kw in descending order.
select Installation_Id, City, Capacity_Kw, Vendor
from Solar
where State = 'Rajasthan' and Capacity_Kw > 5
order by Capacity_Kw desc;

# Write a query to find the average Gross_Cost_Rs and total Monthly_Generation_Units, grouped by State,
# but only include states where the average Capacity_Kw is greater than 4. Sort by average cost descending.
select State, avg(Capacity_Kw) as Average_Capacity, avg(Gross_Cost_Rs) as Average_Gross_Cost, sum(Monthly_Generation_Units) as Total_Units
from Solar
group by State
having avg(Capacity_Kw) > 4
order by Average_Gross_Cost desc;

# For each row, show Installation_Id, State, Capacity_Kw, and a new column State_Rank that ranks installations 
# within each state by Capacity_Kw in descending order (highest capacity = rank 1).
# Only return rows where State_Rank <= 3 — i.e., the top 3 installations by capacity in each state.
SELECT *
FROM (
    SELECT 
        Installation_Id, 
        State, 
        Capacity_Kw,
        RANK() OVER (PARTITION BY State ORDER BY Capacity_Kw desc) AS State_Rank
    FROM Solar
) AS ranked
WHERE State_Rank <= 3;

# write a query to find the number of installations and total Gross_Cost_Rs, grouped by year and month (e.g., "2024-08"), 
# but only for installations that are not in 'Unknown' city, sorted chronologically (oldest first).
# Expected output columns: Year_Month, Total_Installations, Total_Cost.
select date_format(Installation_Date, "%Y-%m") as Year_Months, count(Installation_Id) as Total_Installation, sum(Gross_Cost_Rs) as Total_Cost
from Solar
where City <> 'Unknown'
group by Year_Months
order by Year_Months asc;

# Write a query to find, for each State, the percentage of Gross_Cost_Rs covered by total subsidy (Central + State), like:
# Subsidy_Percentage = (SUM(Central_Subsidy_Rs) + SUM(State_Subsidy_Rs)) / SUM(Gross_Cost_Rs) * 100
SELECT 
    State,
    COUNT(Installation_Id) AS Total_Installations,
    ROUND((sum(Central_Subsidy_Rs) + sum(State_Subsidy_Rs)) / Sum(Gross_Cost_Rs) * 100, 2 ) AS Subsidy_Percentage
FROM Solar
GROUP BY State
HAVING Total_Installations > 100
ORDER BY  Subsidy_Percentage desc;

# Find the top vendor by total installations in each state — i.e., for every state, 
# which single Vendor has the most rows? Return State, Vendor, and Installation_Count.
select State, Vendor, Installation_Count
from (
select State, Vendor, count(Installation_Id) as Installation_Count,
row_number() over(partition by State order by count(Installation_Id) desc) as rn
from Solar 
group by State, Vendor
) as Vendor_Counts
where rn = 1
order by Installation_Count desc;