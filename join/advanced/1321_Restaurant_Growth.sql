/*
problem
    customer (customer_id, name, visited_on, amount). primary (customer_id, visited_on)
    => compute moving average of customer spending in window 7 day (current + 6 previous day)
strategy one
    using window function with specified frame
    reference for specified fram in mysql: https://dev.mysql.com/doc/refman/8.0/en/window-functions-frames.html
    in this case is day we use expression: range between interval 6 day preceeding and current row
    filter the day which do not have enough of 7 days in the window


    do not use window function in this case, because if data point is missing on day (visited_on)
    using subquery for this type of problem

*/
SELECT
    visited_on,
    (
        SELECT SUM(amount)
        FROM customer
        WHERE visited_on BETWEEN DATE_SUB(c.visited_on, INTERVAL 6 DAY) AND c.visited_on
    ) AS amount,
    ROUND(
        (
            SELECT SUM(amount) / 7
            FROM customer
            WHERE visited_on BETWEEN DATE_SUB(c.visited_on, INTERVAL 6 DAY) AND c.visited_on
        ),
        2
    ) AS average_amount
FROM customer c
WHERE visited_on >= (
        SELECT DATE_ADD(MIN(visited_on), INTERVAL 6 DAY)
        FROM customer
    )
GROUP BY visited_on;