select *from sales.transactions;

 with cte1 as
 (
 select sum(sales_qty * sales_amount )  as revenue , month(order_date)  as month, year(order_date) as year from sales.transactions
 group by month(order_date) , year(order_date) 
 )
 
 select  revenue , year , month , round(coalesce(((revenue - prev_value ) /prev_value* 100) , 0) , 2) as yoy from
 (
 select revenue , year , month ,
 lag (revenue) over ( partition by year order by month , year ) as prev_value
 from cte1
 ) a
 
 
