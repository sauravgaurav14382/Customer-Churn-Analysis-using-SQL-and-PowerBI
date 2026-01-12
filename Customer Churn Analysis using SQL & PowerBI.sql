SELECT * FROM sysdb.stg_churn;

-- Data Exploration

SELECT Gender, Count(Gender) as TotalCount,
round(Count(Gender) * 100.0 / (Select Count(*) from sysdb.stg_Churn), 4)  as Percentage
from sysdb.stg_churn
Group by Gender;

SELECT Contract, Count(Contract) as TotalCount,
Round(Count(Contract) * 100.0 / (Select Count(*) from sysdb.stg_Churn), 4)  as Percentage
from sysdb.stg_churn
Group by Contract;

SELECT Customer_Status, Count(Customer_Status) as TotalCount, Sum(Total_Revenue) as TotalRev,
Round(Sum(Total_Revenue) / (Select sum(Total_Revenue) from sysdb.stg_Churn) * 100, 4)  as RevPercentage
from sysdb.stg_Churn
Group by Customer_Status;

SELECT State, Count(State) as TotalCount,
Round(Count(State) * 100.0 / (Select Count(*) from sysdb.stg_Churn), 4)  as Percentage
from sysdb.stg_Churn
Group by State
Order by Percentage desc;

-- Identify Null Values in each column of the table

SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM sysdb.stg_Churn;

-- Fix the Null Values

CREATE TABLE sysdb.prod_Churn AS
SELECT *
FROM sysdb.stg_Churn;

UPDATE sysdb.prod_Churn 
SET 
    Value_Deal = 'None' 
    WHERE IFNULL(TRIM(Value_Deal), '') = '';
    
UPDATE sysdb.prod_Churn 
SET 
    Multiple_Lines = 'No' 
    WHERE IFNULL(TRIM(Multiple_Lines), '') = '';

UPDATE sysdb.prod_Churn 
SET 
    Internet_Type = 'None' 
    WHERE IFNULL(TRIM(Internet_Type), '') = '';

UPDATE sysdb.prod_Churn 
SET 
    Online_Security = 'No' 
    WHERE IFNULL(TRIM(Online_Security), '') = '';

UPDATE sysdb.prod_Churn 
SET 
    Online_Backup = 'No' 
    WHERE IFNULL(TRIM(Online_Backup), '') = '';

UPDATE sysdb.prod_Churn 
SET 
    Device_Protection_Plan = 'No' 
    WHERE IFNULL(TRIM(Device_Protection_Plan), '') = '';

UPDATE sysdb.prod_Churn 
SET 
    Premium_Support = 'No' 
    WHERE IFNULL(TRIM(Premium_Support), '') = '';

UPDATE sysdb.prod_Churn 
SET 
    Streaming_TV = 'No' 
    WHERE IFNULL(TRIM(Streaming_TV), '') = '';

UPDATE sysdb.prod_Churn 
SET 
    Streaming_Movies = 'No' 
    WHERE IFNULL(TRIM(Streaming_Movies), '') = '';

UPDATE sysdb.prod_Churn 
SET 
    Streaming_Music = 'No' 
    WHERE IFNULL(TRIM(Streaming_Music), '') = '';

UPDATE sysdb.prod_Churn 
SET 
    Unlimited_Data = 'No' 
    WHERE IFNULL(TRIM(Unlimited_Data), '') = '';

UPDATE sysdb.prod_Churn 
SET 
    Churn_Category = 'Others' 
    WHERE IFNULL(TRIM(Churn_Category), '') = '';

UPDATE sysdb.prod_Churn 
SET 
    Churn_Reason = 'Others' 
    WHERE IFNULL(TRIM(Churn_Reason), '') = '';

select * from sysdb.prod_churn;

-- View creation

Create View vw_ChurnData as
	select * from sysdb.prod_Churn where Customer_Status In ('Churned', 'Stayed');

Create View vw_JoinData as
	select * from sysdb.prod_Churn where Customer_Status = 'Joined';
    
    
-------------------------------- Caution ------------------------------------------
    
drop view vw_churndata;
drop view vw_joindata;
drop table sysdb.prod_churn;