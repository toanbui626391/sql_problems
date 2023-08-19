/*
problem
    logs (log_id)
    => report on continuous id
strategy
    row_number() over(order by log_id) as rnb
    rnb - log_id will mark continuous status
    group by (rnb-log_id). min(log_id) max(log_id) to find start_date and end_date of period
*/
WITH tb1 AS (
    SELECT log_id, ROW_NUMBER() OVER (ORDER BY log_id) AS r
    FROM Logs
)

SELECT MIN(log_id) AS START_ID, MAX(log_id) AS END_ID
FROM tb1
GROUP BY log_id-r;