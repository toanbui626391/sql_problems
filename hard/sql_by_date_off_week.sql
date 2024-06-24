/*
problem: 1479. Sales by Day of the Week
  summarise sale by day of week for each item category
learning
  because mysql do not support pivot we use group by combine with sum(if())
  use dateofweek() function which return date of week (Sunday=1, Monday=2 and so on)
*/

SELECT item_category AS Category,
    SUM(IF(DAYOFWEEK(order_date)=2, quantity,0)) AS Monday,
    SUM(IF(DAYOFWEEK(order_date)=3, quantity,0)) AS Tuesday,
    SUM(IF(DAYOFWEEK(order_date)=4, quantity,0)) AS Wednesday,
    SUM(IF(DAYOFWEEK(order_date)=5, quantity,0)) AS Thursday,
    SUM(IF(DAYOFWEEK(order_date)=6, quantity,0)) AS Friday,
    SUM(IF(DAYOFWEEK(order_date)=7, quantity,0)) AS Saturday,
    SUM(IF(DAYOFWEEK(order_date)=1, quantity,0)) AS Sunday
FROM Orders RIGHT JOIN Items
    USING(item_id)
GROUP BY Category
ORDER BY Category;