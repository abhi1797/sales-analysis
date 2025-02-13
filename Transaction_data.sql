--Creating transaction table
CREATE TABLE transactions (
    TransactionID SERIAL PRIMARY KEY,
    CustomerID INT,
    TransactionDate DATE,
    TransactionAmount DECIMAL(10,2) ,
    PaymentMethod VARCHAR(50),
    Quantity INT CHECK (Quantity > 0),
    DiscountPercent DECIMAL(5,2) CHECK (DiscountPercent BETWEEN 0 AND 100),
    City VARCHAR(100),
    StoreType VARCHAR(50),
    CustomerAge INT CHECK (CustomerAge > 0),
    CustomerGender VARCHAR(10) CHECK (CustomerGender IN ('Male', 'Female', 'Other')),
    LoyaltyPoints INT DEFAULT 0,
    ProductName VARCHAR(255),
    Region VARCHAR(100),
    Returned VARCHAR(100),
    FeedbackScore INT CHECK (FeedbackScore BETWEEN 1 AND 5),
    ShippingCost DECIMAL(8,2) DEFAULT 0.00,
    DeliveryTimeDays INT CHECK (DeliveryTimeDays >= 0),
    IsPromotional VARCHAR(100)
);



--updating the null valueon PaymentMethod column with unknown
UPDATE transactions SET PaymentMethod = 'Unknown' WHERE PaymentMethod IS NULL;
UPDATE 50000



--updating customer age with the average age
UPDATE transactions 
SET customerage = (
    SELECT ROUND(AVG(customerage)) FROM transactions
)
WHERE customerage IS NULL;


-- setting the unknown Transaction date with 2000-01-01
UPDATE transactions
SET TransactionDate = '2000-01-01'
WHERE TransactionDate IS NULL;



--set product name with unknown product 
UPDATE transactions
SET ProductName = 'Unknown Product'
WHERE ProductName IS NULL;




--Key Aggregate Metrics
-- Total Sales Revenue
SELECT SUM(TransactionAmount) AS Total_Revenue FROM transactions;

-- Total Number of Transactions
SELECT COUNT(TransactionID) AS Total_Transactions FROM transactions;

-- Average Transaction Amount
SELECT AVG(TransactionAmount) AS Avg_TransactionAmount FROM transactions;

-- Total Quantity Sold
SELECT SUM(Quantity) AS Total_Quantity_Sold FROM transactions;

-- Average Discount Given
SELECT AVG(DiscountPercent) AS Avg_Discount FROM transactions;



--Sales by City
SELECT City, SUM(TransactionAmount) AS Revenue, COUNT(TransactionID) AS Total_Transactions
FROM transactions
GROUP BY City
ORDER BY Revenue DESC;
-- In the above query Kolkata generating the most revenue followed by Ahmedabad and 
--Bangalore on the third.



--Sales by Store Type
SELECT StoreType, SUM(TransactionAmount) AS Revenue, COUNT(TransactionID) AS Total_Transactions
FROM transactions
GROUP BY StoreType 
ORDER BY Revenue DESC;
--Online Stores generating the most revenue



--Sales by Product Category
SELECT ProductName, SUM(TransactionAmount) AS Revenue, SUM(Quantity) AS Total_Quantity
FROM transactions
GROUP BY ProductName
ORDER BY Revenue DESC
LIMIT 10; 
-- Top 10 best-selling products



--Sales by Region
SELECT Region, SUM(TransactionAmount) AS Revenue, COUNT(TransactionID) AS Transactions
FROM transactions
GROUP BY Region
ORDER BY Revenue DESC;
--The South region generates the highest revenue (3.2 billion),
--making it the top-performing region in terms of sales.
--Potential Factors Driving High Revenue:
--1.Presence of more premium stores or high-ticket items sold.
--2.Higher purchasing power in the region.
--3.More loyal customers or effective marketing campaigns.



--Payment Method Preference
SELECT PaymentMethod, COUNT(TransactionID) AS Transaction_Count, SUM(TransactionAmount) AS Revenue
FROM transactions
GROUP BY PaymentMethod
ORDER BY Revenue DESC;
--Cash mode of payment tops the list with debit card payment on second.


-- Customer Segmentation Based on Age Group
SELECT 
    CASE 
        WHEN CustomerAge BETWEEN 18 AND 25 THEN '18-25'
        WHEN CustomerAge BETWEEN 26 AND 35 THEN '26-35'
        WHEN CustomerAge BETWEEN 36 AND 45 THEN '36-45'
        WHEN CustomerAge BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+' 
    END AS Age_Group,
    COUNT(TransactionID) AS Total_Transactions,
    SUM(TransactionAmount) AS Revenue
FROM transactions
GROUP BY Age_Group
ORDER BY Revenue DESC;
--This shows the age group of 46-60 make the most of our revenue 
--and number of transactions are also high in this age group.



--Product Preferences by Age Group
SELECT Age_Group, ProductName, SUM(TransactionAmount) AS Revenue
FROM (
    SELECT 
        CASE 
            WHEN CustomerAge BETWEEN 18 AND 25 THEN '18-25'
            WHEN CustomerAge BETWEEN 26 AND 35 THEN '26-35'
            WHEN CustomerAge BETWEEN 36 AND 45 THEN '36-45'
            WHEN CustomerAge BETWEEN 46 AND 60 THEN '46-60'
            ELSE '60+' 
        END AS Age_Group,
        ProductName, TransactionAmount
    FROM transactions
) AS ProductData
GROUP BY Age_Group, ProductName
ORDER BY Age_Group, Revenue DESC;
--General trend can be seen in the age group of 18-25
--who are mostlt students and early working professionals to buy laptop.




--Store Performance Over Time
SELECT StoreType, EXTRACT(MONTH FROM TransactionDate) AS Month, SUM(TransactionAmount) AS Monthly_Revenue
FROM transactions
GROUP BY StoreType, Month
ORDER BY Month,Monthly_Revenue desc ;
--Online shoping is the preference in 8 months in a year,
--this shows that people like buying stuffs online.




--Average Feedback Score by Product
SELECT ProductName, AVG(FeedbackScore) AS Avg_Feedback
FROM transactions
GROUP BY ProductName
ORDER BY Avg_Feedback DESC;
--Average feedabck score of sofa is the most which shows customer satisfaction.




--Shipping Cost vs. Transaction Amount
SELECT 
    CASE 
        WHEN ShippingCost BETWEEN 0 AND 50 THEN 'Low'
        WHEN ShippingCost BETWEEN 51 AND 150 THEN 'Medium'
        ELSE 'High'
    END AS Shipping_Cost_Bracket,
    COUNT(TransactionID) AS Total_Transactions,
    SUM(TransactionAmount) AS Total_Revenue
FROM transactions
GROUP BY Shipping_Cost_Bracket
ORDER BY Total_Revenue DESC;
--Customers are willing to pay extra for faster or premium shipping.
--But we can see low shipping_cost_bracket has more number of transactions which suggest
--that customers prefer low-cost or free shipping options as well.




--Monthly Revenue Growth
SELECT EXTRACT(YEAR FROM TransactionDate) AS Year, 
       EXTRACT(MONTH FROM TransactionDate) AS Month, 
       SUM(TransactionAmount) AS Monthly_Revenue
FROM transactions
GROUP BY Year, Month
ORDER BY Year, Month;
--This gives us an insight for the monthly_revenue with 
--lowest revenue on the last month of the year and highest revenue coming from the year that is unknown or not in our database.




-- Sales Seasonality
SELECT EXTRACT(DOW FROM TransactionDate) AS Day_Of_Week, SUM(TransactionAmount) AS Revenue
FROM transactions
GROUP BY Day_Of_Week
ORDER BY Revenue DESC;
--6th day being Saturday( weekend ) shows the most revenue 
--which gives us an insight that the shoping is mostly done on the weekend.




--SQL Query to Analyze Gender & Region Sales
SELECT 
    CustomerGender, 
    Region, 
    COUNT(TransactionID) AS Total_Transactions, 
    SUM(TransactionAmount) AS Total_Revenue, 
    AVG(TransactionAmount) AS Avg_Spending
FROM transactions
GROUP BY CustomerGender, Region
ORDER BY Region,Total_Revenue DESC;
--In the above query identifies gender-based spending behavior across different regions.
--Shows whether a specific region is more profitable than others.
--Helps in personalized marketing campaigns based on gender and location.




--Query to Analyze Impact of Discounts on Revenue
SELECT 
    DiscountPercent, 
    COUNT(TransactionID) AS Transactions, 
    SUM(TransactionAmount) AS Total_Revenue, 
    AVG(TransactionAmount) AS Avg_Spending
FROM transactions
GROUP BY DiscountPercent
ORDER BY Total_Revenue DESC;
--The above query puts light on the discount percent and the total_revenue , with only 11.66 percent
--descount it generated over 3827406.00 and the second its 34.89 % discounted items.




--Query to Analyze Returns vs. Feedback Score
SELECT 
    FeedbackScore, 
    COUNT(TransactionID) AS Total_Transactions, 
    SUM(CASE WHEN Returned = 'Yes' THEN 1 ELSE 0 END) AS Total_Returns,
    ROUND((SUM(CASE WHEN Returned = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(TransactionID), 2) AS Return_Percentage
FROM transactions
GROUP BY FeedbackScore
ORDER BY FeedbackScore DESC;
--The above query shows that the High return rates correlate with low feedback scores.
--Better feedback scores indicate higher customer satisfaction.




--Query to Find Impact of Shipping on Sales
SELECT 
    ShippingCost, 
    AVG(DeliveryTimeDays) AS Avg_Delivery_Time, 
    COUNT(TransactionID) AS Total_Transactions, 
    SUM(TransactionAmount) AS Total_Revenue
FROM transactions
GROUP BY ShippingCost
ORDER BY ShippingCost DESC;
--The above query shows that higher shipping costs reduce transaction volume.
--Customers prefer lower shipping costs, even if it means longer delivery times.
--Optimal shipping cost balance can be identified to maximize conversions.