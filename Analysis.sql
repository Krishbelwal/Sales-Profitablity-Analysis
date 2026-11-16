
Select * from Fact_Table;
Select * from Dim_customers;
Select * from Dim_products;



-- 1

Select p.category , sum(F.Revenue) , sum(F.profit) ,  SUM(F.profit) / SUM(F.Revenue) * 100 , sum(f.discount) , sum(shipping_cost)
From Dim_products p Left join Fact_Table F
on p.Row_id = F.Row_id
Group by p.category;


Select p.sub_category , sum(F.Revenue) , sum(F.profit) ,  SUM(F.profit) / SUM(F.Revenue) * 100 , sum(f.discount) , sum(shipping_cost)
From Dim_products p Left join Fact_Table F
on p.Row_id = F.Row_id
Group by p.sub_category;



-- 2 - Region and Market performance -- 
                                            
Select C.region , Sum(f.Revenue) , Sum(F.profit) ,  SUM(F.profit) / SUM(F.Revenue) * 100 AS Profit_Margin,
    SUM(F.shipping_cost) AS Total_Shipping_Cost,
    SUM(F.Discount) AS Total_Discount
From Dim_customers C join Fact_table F
On C.Row_id = F.Row_id
Group by C.region
Order by Sum(f.Revenue) Desc;



-- 3  Customer segment Analysis 

Select C.segment , Sum(f.Revenue) , Sum(F.profit) ,  SUM(F.profit) / SUM(F.Revenue) * 100 AS Profit_Margin,
    SUM(F.shipping_cost) AS Total_Shipping_Cost,
    SUM(F.Discount) AS Total_Discount
From Dim_customers C Left join Fact_Table F
On C.Row_id = F.Row_id
group by C.segment 
order by sum(F.Revenue) Desc;
