/*
problem
    failed (fail_date)
    succeeded (success_date)
    each date we will have record of success for fail for each talbe
    => write sql to report continuous state from 2019-01-01 to 2019-2
strategy
    use union all to combine failed and succeeded table with status
    make sequence with row_number() (partition by status order by date) as rnb1
    make sequence with row_number() (order by date) rnb2
    rnb2 - rnb1 will mark for each continuous tate
    group by rnb2-rnb2, state and compute min(date), max(date) to find start_date and end_date
*/
WITH tb1 AS (
    SELECT fail_date AS date, 'failed' AS s
    FROM Failed
    UNION
    SELECT success_date AS date, 'succeeded' AS s
    FROM Succeeded
),
tb2 AS (
    SELECT *, 
        ROW_NUMBER() OVER (PARTITION BY s ORDER BY date) AS r,
        ROW_NUMBER() OVER (ORDER BY date) AS r2
    FROM tb1
    WHERE Year(date) = 2019
)

-- contiguous dates with same period state share the same r2-r,
-- so in a group with same r2-4, the smallest date is start date and the largest date is end date
SELECT s AS period_state, MIN(date) AS start_date, MAX(date) AS end_date
FROM tb2
GROUP BY r2-r, s
ORDER BY start_date;