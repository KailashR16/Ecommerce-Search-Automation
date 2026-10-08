CREATE DATABASE ecommerce_sales;
USE ecommerce_sales;
CREATE TABLE ecommerce_orders (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Customer_Name VARCHAR(100),
    Product VARCHAR(100),
    Category VARCHAR(50),
    Region VARCHAR(50),
    Quantity INT,
    Sales DECIMAL(12,2),
    Discount DECIMAL(5,2),
    Profit DECIMAL(12,2)
);
SELECT COUNT(*) FROM ecommerce_orders;
SELECT * FROM ecommerce_orders LIMIT 5;
SHOW TABLES;
SELECT COUNT(*) FROM ecommerce_orders;
SELECT COUNT(*) FROM ecommerce_orders;
SELECT * FROM ecommerce_orders LIMIT 5;
SELECT SUM(Sales) AS Total_Sales
FROM ecommerce_orders;
SELECT SUM(Profit) AS Total_Profit
FROM ecommerce_orders;
SELECT COUNT(*) AS Total_Orders
FROM ecommerce_orders;
SELECT SUM(Quantity) AS Total_Quantity
FROM ecommerce_orders;
SELECT AVG(Sales) AS Average_Order_Value
FROM ecommerce_orders;
SELECT Category, SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Category
ORDER BY Total_Sales DESC;
SELECT Region, SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Region
ORDER BY Total_Sales DESC;
SELECT Product, SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Product
ORDER BY Total_Sales DESC;
SELECT MONTH(Order_Date) AS Month,
       SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY MONTH(Order_Date)
ORDER BY Month;
SELECT 
    MONTHNAME(Order_Date) AS Month,
    SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY MONTH(Order_Date);
SELECT 
      Category,SUM(Profit) AS Total_Profit
      FROM ecommerce_orders
      GROUP BY Category
      ORDER BY Total_Profit DESC;
      SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM ecommerce_orders
GROUP BY Category
ORDER BY Profit_Margin DESC;
SELECT Product, SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 5;
SELECT 
	  ROUND(
      (SUM(Sales)/(SELECT SUM(Sales) FROM ecommerce_orders))
      *100,2)As Top_5_Sales_Percentage
      FROM(
           SELECT Product,SUM(Sales) As Sales
           From ecommerce_orders
           GROUP BY Product
           ORDER BY Sales DESC
           LIMIT 5
           )As Top_5;
SELECT Product, SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 5;
SELECT
    ROUND(
        (SUM(Sales) / (SELECT SUM(Sales) FROM ecommerce_orders)) * 100,
        2
    ) AS Top_5_Sales_Percentage
FROM (
    SELECT Product, SUM(Sales) AS Sales
    FROM ecommerce_orders
    GROUP BY Product
    ORDER BY Sales DESC
    LIMIT 5
) AS Top_5;
SELECT 
    7998300 / 9248905 * 100 AS Percentage;
SELECT
    SUM(Total_Sales) AS Top_5_Total,
    (SELECT SUM(Sales) FROM ecommerce_orders) AS Overall_Total,
    ROUND(
        SUM(Total_Sales) /
        (SELECT SUM(Sales) FROM ecommerce_orders) * 100,
        2
    ) AS Top_5_Percentage
FROM (
    SELECT Product, SUM(Sales) AS Total_Sales
    FROM ecommerce_orders
    GROUP BY Product
    ORDER BY Total_Sales DESC
    LIMIT 5
) AS Top_5;
SELECT Product, SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 5;
SELECT Category, COUNT(*) AS Total_Orders
FROM ecommerce_orders
GROUP BY Category
ORDER BY Total_Orders DESC;
SELECT Region, COUNT(*) AS Total_Orders
FROM ecommerce_orders
GROUP BY Region
ORDER BY Total_Orders DESC;
SELECT Product, COUNT(*) AS Total_Orders
FROM ecommerce_orders
GROUP BY Product
ORDER BY Total_Orders DESC;
SELECT Category, ROUND(AVG(Sales), 2) AS Average_Order_Value
FROM ecommerce_orders
GROUP BY Category
ORDER BY Average_Order_Value DESC;
SELECT Category,
ROUND(AVG(Discount),2)AS Average_Discount,
ROUND(AVG(Profit),2)AS Average_Profit
FROM ecommerce_orders
GROUP BY Category;
SELECT Category, SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Category
HAVING SUM(Sales) > 1000000
ORDER BY Total_Sales DESC;
SELECT Category, SUM(Sales) AS Total_Sales
FROM ecommerce_orders
WHERE Sales > 10000
GROUP BY Category
HAVING SUM(Sales) > 1000000
ORDER BY Total_Sales DESC;
SELECT Region, SUM(Sales) AS Total_Sales
FROM ecommerce_orders
WHERE Discount >= 10
GROUP BY Region
ORDER BY Total_Sales DESC;
SELECT Product, ROUND(AVG(Discount), 2) AS Average_Discount
FROM ecommerce_orders
GROUP BY Product
ORDER BY Average_Discount DESC;
SELECT
    Product,
    ROUND(AVG(Discount), 2) AS Average_Discount,
    ROUND(AVG(Profit), 2) AS Average_Profit
FROM ecommerce_orders
GROUP BY Product
ORDER BY Average_Discount DESC;
SELECT
    Product,
    SUM(Sales) AS Total_Sales,
    CASE
        WHEN SUM(Sales) >= 1000000 THEN 'High'
        WHEN SUM(Sales) >= 500000 THEN 'Medium'
        ELSE 'Low'
    END AS Sales_Level
FROM ecommerce_orders
GROUP BY Product
ORDER BY Total_Sales DESC;
SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    CASE
        WHEN SUM(Sales) >= 5000000 THEN 'High'
        WHEN SUM(Sales) >= 1000000 THEN 'Medium'
        ELSE 'Low'
    END AS Performance
FROM ecommerce_orders
GROUP BY Category
ORDER BY Total_Sales DESC;
SELECT 
    MONTHNAME(Order_Date) AS Month,
    SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY Total_Sales DESC;
SELECT ROUND((1083230.00-575430.00)/1083230.00*100,2)
AS Decrease_Sales_Percentage;
SELECT
    MONTHNAME(Order_Date) AS Month,
    SUM(Sales) AS Total_Sales,
    LAG(SUM(Sales)) OVER (
        ORDER BY MONTH(Order_Date)
    ) AS Previous_Month_Sales
FROM ecommerce_orders
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY MONTH(Order_Date);
SELECT
    MONTHNAME(Order_Date) AS Month,
    SUM(Sales) AS Total_Sales,
    LAG(SUM(Sales)) OVER (
        ORDER BY MONTH(Order_Date)
    ) AS Previous_Month_Sales,
    ROUND(
        (
            (SUM(Sales) - LAG(SUM(Sales)) OVER (
                ORDER BY MONTH(Order_Date)
            ))
            / LAG(SUM(Sales)) OVER (
                ORDER BY MONTH(Order_Date)
            )
        ) * 100,
        2
    ) AS MoM_Change_Percentage
FROM ecommerce_orders
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY MONTH(Order_Date);
SELECT
    MONTHNAME(Order_Date) AS Month,
    ROUND(
        (
            (SUM(Sales) - LAG(SUM(Sales)) OVER (
                ORDER BY MONTH(Order_Date)
            ))
            / LAG(SUM(Sales)) OVER (
                ORDER BY MONTH(Order_Date)
            )
        ) * 100,
        2
    ) AS MoM_Change_Percentage
FROM ecommerce_orders
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY MoM_Change_Percentage ASC;
SHOW TABLES;
SELECT
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;
SELECT DISTINCT Category
FROM ecommerce_orders;
SELECT MAX(Sales)AS Highest_Sales,
       MIN(Sales)AS Lowest_Sales
       FROM ecommerce_orders;
SELECT * FROM ecommerce_orders
WHERE Category ='Electronics'AND Sales>20000;
SELECT Product, COUNT(*) AS Total_Orders
FROM ecommerce_orders
WHERE Product LIKE '%phone%'
GROUP BY Product;
SELECT Order_ID,Product,Sales
FROM ecommerce_orders
WHERE Sales BETWEEN 10000 AND 20000;
SELECT * FROM ecommerce_orders
WHERE Category IN('Electronics','Furniture');
SELECT Order_ID,Product,Sales FROM ecommerce_orders
WHERE Sales>(Select AVG(Sales) FROM ecommerce_orders);
SELECT ROUND(AVG(Sales),2) AS Average_Sales
FROM ecommerce_orders;
SELECT COUNT(*) AS Orders_above_average FROM ecommerce_orders
WHERE Sales>(SELECT AVG(Sales)FROM ecommerce_orders);
SELECT COUNT(DISTINCT Product) AS Unique_Products
FROM ecommerce_orders
WHERE Category IN('Electronics','Furniture');
CREATE TABLE category_targets (
    Category VARCHAR(50),
    Target_Sales DECIMAL(12,2)
);
INSERT INTO category_targets (Category, Target_Sales)
VALUES
('Electronics', 7000000),
('Furniture', 2000000),
('Accessories', 500000),
('Home', 300000);
SELECT
    o.Category,
    SUM(o.Sales) AS Actual_Sales,
    t.Target_Sales
FROM ecommerce_orders o 
JOIN category_targets t
    ON o.Category = t.Category
GROUP BY o.Category, t.Target_Sales;
SELECT
    o.Category,
    SUM(o.Sales) AS Actual_Sales,
    t.Target_Sales,
    t.Target_Sales - SUM(o.Sales) AS Target_Gap
FROM ecommerce_orders o
JOIN category_targets t
    ON o.Category = t.Category
GROUP BY o.Category, t.Target_Sales
ORDER BY Target_Gap DESC;
SELECT
    o.Category,
    SUM(o.Sales) AS Actual_Sales,
    t.Target_Sales,
    ROUND((SUM(o.Sales) / t.Target_Sales) * 100, 2) AS Target_Achievement
FROM ecommerce_orders o
JOIN category_targets t
    ON o.Category = t.Category
GROUP BY o.Category, t.Target_Sales
ORDER BY Target_Achievement DESC;
SELECT
    o.Category,
    SUM(o.Sales) AS Actual_Sales,
    t.Target_Sales,
    CASE
        WHEN SUM(o.Sales) >= t.Target_Sales THEN 'Achieved'
        ELSE 'Not Achieved'
    END AS Target_Status
FROM ecommerce_orders o
JOIN category_targets t
    ON o.Category = t.Category
GROUP BY o.Category, t.Target_Sales;
SELECT
    o.Category,
    SUM(o.Sales) AS Actual_Sales,
    t.Target_Sales
FROM ecommerce_orders o
JOIN category_targets t
    ON o.Category = t.Category
WHERE SUM(o.Sales) < t.Target_Sales
GROUP BY o.Category, t.Target_Sales;
SELECT
    o.Category,
    SUM(o.Sales) AS Actual_Sales,
    t.Target_Sales
FROM ecommerce_orders o
JOIN category_targets t
    ON o.Category = t.Category
GROUP BY o.Category, t.Target_Sales
HAVING SUM(o.Sales) < t.Target_Sales
ORDER BY Actual_Sales DESC;
SELECT
    Customer_Name,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 5;
SELECT
    Customer_Name,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    ROUND(AVG(Sales), 2) AS Average_Order_Value
FROM ecommerce_orders
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 5;
SELECT
    Customer_Name,
    Product,
    SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Customer_Name, Product
ORDER BY Total_Sales DESC;
SELECT
    Customer_Name,
    COUNT(*) AS Total_Orders
FROM ecommerce_orders
GROUP BY Customer_Name
HAVING COUNT(*) >= 2
ORDER BY Total_Orders DESC;
SELECT
    Customer_Name,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Customer_Name
HAVING COUNT(*) >= 2
ORDER BY Total_Sales DESC
LIMIT 5;
WITH Customer_Sales AS(SELECT Customer_Name,SUM(Sales) AS Total_Sales
FROM ecommerce_orders
GROUP BY Customer_Name)
SELECT *FROM Customer_Sales
ORDER BY Total_Sales DESC
LIMIT 5;
SELECT
    Customer_Name,
    SUM(Sales) AS Total_Sales,
    ROW_NUMBER() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM ecommerce_orders
GROUP BY Customer_Name;
SELECT
    Customer_Name,
    SUM(Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM ecommerce_orders
GROUP BY Customer_Name;
SELECT Category,Product,SUM(Sales)AS Total_Sales,
RANK() OVER(
PARTITION by Category
ORDER by SUM(Sales) DESC
) AS Product_Rank
FROM ecommerce_orders
GROUP by Category,Product;
WITH Product_Ranking AS (
SELECT
        Category,
        Product,
        SUM(Sales) AS Total_Sales,
        RANK() OVER (
            PARTITION BY Category
            ORDER BY SUM(Sales) DESC
        ) AS Product_Rank
    FROM ecommerce_orders
    GROUP BY Category, Product
)
SELECT
    Category,
    Product,
    Total_Sales
FROM Product_Ranking
WHERE Product_Rank = 1;
SELECT
    Category,
    Product,
    SUM(Sales) AS Total_Sales,
    DENSE_RANK() OVER (
        PARTITION BY Category
        ORDER BY SUM(Sales) DESC
    ) AS Sales_Rank
FROM ecommerce_orders
GROUP BY Category, Product;
SELECT
    SUM(CASE
        WHEN Category = 'Electronics' THEN Sales
        ELSE 0
    END) AS Electronics_Sales,

    SUM(CASE
        WHEN Category <> 'Electronics' THEN Sales
        ELSE 0
    END) AS Other_Categories_Sales
FROM ecommerce_orders;
SELECT
    Category,
    COUNT(*) AS Total_Orders,
    SUM(
        CASE
            WHEN Discount >= 10 THEN 1
            ELSE 0
        END
    ) AS High_Discount_Orders
FROM ecommerce_orders
GROUP BY Category
ORDER BY High_Discount_Orders DESC;
SELECT
    Category,
    ROUND(
        SUM(CASE WHEN Discount >= 10 THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS High_Discount_Percentage
FROM ecommerce_orders
GROUP BY Category
ORDER BY High_Discount_Percentage DESC;
SELECT
    Category,
    ROUND(
        SUM(CASE WHEN Discount >= 10 THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS High_Discount_Percentage
FROM ecommerce_orders
GROUP BY Category
HAVING
    SUM(CASE WHEN Discount >= 10 THEN 1 ELSE 0 END)
    / COUNT(*) * 100 >= 30
ORDER BY High_Discount_Percentage DESC;
SELECT COUNT(*) AS Missing_Customer_Names
FROM ecommerce_orders
WHERE Customer_Name IS NULL;
SELECT
    Order_ID,
    COUNT(*) AS Order_Count
FROM ecommerce_orders
GROUP BY Order_ID
HAVING COUNT(*) > 1;
SELECT COUNT(*) AS Invalid_Sales
FROM ecommerce_orders
WHERE Sales <= 0;
SELECT COUNT(*) AS Invalid_Quantity
FROM ecommerce_orders
WHERE Quantity <= 0;
SELECT COUNT(*) AS Invalid_Discount
FROM ecommerce_orders
WHERE Discount < 0 OR Discount > 100;
SELECT COUNT(*) AS Missing_Order_Dates
FROM ecommerce_orders
WHERE Order_Date IS NULL;
SELECT COUNT(*) AS Missing_Profit
FROM ecommerce_orders
WHERE Profit IS NULL;
SELECT COUNT(*) AS Total_Rows
FROM ecommerce_orders;
SELECT
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Overall_Profit_Margin
FROM ecommerce_orders;
SELECT
    Category,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM ecommerce_orders
GROUP BY Category
ORDER BY Profit_Margin DESC;
SELECT
    o.Category,
    ROUND((SUM(o.Profit) / SUM(o.Sales)) * 100, 2) AS Profit_Margin,
    t.Target_Sales,
    SUM(o.Sales) AS Actual_Sales
FROM ecommerce_orders o
JOIN category_targets t
    ON o.Category = t.Category
GROUP BY o.Category, t.Target_Sales
HAVING SUM(o.Sales) < t.Target_Sales
ORDER BY Profit_Margin DESC;