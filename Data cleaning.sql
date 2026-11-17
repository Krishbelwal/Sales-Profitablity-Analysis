Create Database Sales_Performance_And_Profitability_Analytics;
use Sales_Performance_And_Profitability_Analytics;

Select * from orders;
Select * from returns;
Select * from people;

                                                    
                                                              --   Data cleaning -- 

DESCRIBE Fact_Table;
DESCRIBE Dim_customers;
DESCRIBE Dim_products;
DESCRIBE Dim_orders; 	


                                                             -- checking Null values and handle Them --
Select * from Fact_Table
Where Row_id  is null
Or order_id is null 
or customer_id is null 
or product_id is null 
or sales is null
or  Quantity is null 
or  Discount is null 
or profit is null 
or shipping_cost is null;

Select * from Dim_customers
Where Row_id is null  
or customer_id is null 
or customer_name is null 
or segment is null 
or postal_code is null
or city is null 
or state is null 
or country is null 
or region is null 
or market is null;

SET SQL_SAFE_UPDATES = 0;
Update Dim_customers
Set postal_code = "unknown"
where postal_code is null;
							
                            

Select * from Dim_products
Where Row_id is null  
or product_id is null
or product_name is null
or category is null
or sub_category is null;   

Select * from Dim_orders
Where Row_id is null or
order_id is null or
order_date is null or
ship_date is null 
or ship_mode is null or 
order_priority is null or
Returned is null;                   



                                                         -- Checking Duplicate -- 
                                                       
Select Row_id , Order_id, Product_id , Sales , Quantity , Discount ,  Profit , Shipping_cost , count(*) As duplicate 
From Fact_Table
Group by 
Row_id , Order_id, Product_id , Sales , Quantity , Discount ,  Profit , Shipping_cost
Having count(*) >1;


Select Row_id , customer_id , customer_name , segment , postal_code , city , state , country , region , market , count(*) 
From Dim_customers
Group by
Row_id , customer_id , customer_name , segment , postal_code , city , state , country , region , market
Having 
count(*) > 1; 


Select Row_id , product_id , product_name , category , sub_category
From Dim_products
Group by 
Row_id , product_id , product_name , category , sub_category
Having count(*) >                                         
                                                       
                                                       
                                                       -- Data type -- 

Alter table Fact_Table modify column Shipping_cost int ;


                                                  -- Checking inconsistency --

Select * From Fact_Table
Where Sales < 0
Or 
shipping_cost < 0
Or 
Revenue < 0;






                                                     -- Data Transformation --
ALTER TABLE Fact_Table
ADD COLUMN Revenue int;   
SET SQL_SAFE_UPDATES = 0;
Update Fact_Table
set Revenue = Sales * Quantity;
