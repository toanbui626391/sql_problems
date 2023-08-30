# Write your MySQL query statement below
/*
problem
    prices (product_id, start_date, end_date, price)
    unitssold (product_id, purchase_date, units)
strategy
    find the price at solve using join
    compute average
note:
    join between unitssold and prices on us.product_id = p.product_id and us.purchase_date >= p.start_date and us.purchase_date <= 
*/
SELECT u.product_id, 
    CAST(
        SUM(price*units) * 1.0 / SUM(units) 
        AS DECIMAL(10,2)
    ) AS average_price
FROM UnitsSold u
JOIN Prices p
ON u.product_id = p.product_id 
    AND u.purchase_date >= p.start_date 
    AND u.purchase_date <= p.end_date
GROUP BY u.product_id;