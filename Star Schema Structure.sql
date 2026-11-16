                                              -- Star Schema Structure -- 
                                               
                                               -- Fact Table -- 
Create Table Fact_Table
(
Row_id Int primary key, 
Order_id Varchar(50) , 
Customer_id Varchar(50) , 
Product_id  Varchar(50) , 
Sales Int , 
Quantity int , 
Discount int , 
Profit Decimal(10 , 2),
Shipping_cost Decimal(10 , 2)
);

Select * from Fact_Table;



                                             -- Dimension Tables -- 
Create table Dim_orders
(
Row_id int primary key auto_increment,
order_id varchar(50),
order_date Date , 
ship_date Date , 
ship_mode varchar(50),
order_priority varchar(20),
Returned varchar(20)
);

Create table Dim_customers
(
Row_id Int primary key Auto_increment, 
customer_id varchar(50),
customer_name varchar(50),
segment varchar(50), 
postal_code varchar(50),
city varchar(50),
state varchar(50),
country varchar(50),
region varchar(50),
market varchar(50)
);

Create table Dim_products
(
Row_id Int primary key Auto_increment, 
product_id varchar(50),
product_name varchar(500),
category varchar(50), 
sub_category varchar(50)
);





                                                       -- Insert Data in Fact table -- 
INSERT INTO Fact_Table
SELECT 
    O.`Row ID`,
    O.`Order ID`,
    O.`Customer ID`,
    O.`Product ID`,
    O.Sales,
    O.Quantity,
    O.Discount,
    O.Profit,
    O.`shipping Cost`
FROM Orders O;

                                                         -- Insert Data in Dimension Tables -- 


INSERT INTO Dim_orders (order_id , order_date , ship_date , ship_mode , order_priority , Returned )
SELECT 
    O.`Order ID`,
    O.`Order Date`, 
    O.`Ship Date`, 
    O.`Ship Mode`,
    O.`Order Priority`,
    R.`Returned`
FROM Orders O
LEFT JOIN 
Returns R
On O.`Order ID` = R.`Order ID`;

   
INSERT INTO Dim_customers (customer_id , customer_name , segment, postal_code,city ,state ,country,region,market)
SELECT 
    O.`Customer ID`,
    O.`Customer Name`, 
    O.`Segment`, 
    O.`Postal Code`,
    O.`City`,
    O.`State`,
	O.`Country`,
	O.`Region`,
	O.`Market`
FROM Orders O;

Select * from DIm_customers;


INSERT INTO Dim_products (product_id ,product_name ,category , sub_category)
SELECT 
    O.`Product ID`,
    O.`Product Name`, 
    O.`Category`, 
    O.`Sub-Category`
FROM Orders O;




Select * from orders;
Select * from returns;
Select * from people;
Select * from Fact_Table;
Select * from Dim_customers;
Select * from Dim_products;
Select * from Dim_orders; 
