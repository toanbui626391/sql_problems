/*
problem
    useractivity (username, activity, start_date, end_date)
    => find user's second most recent activity. if user only have one activity show that one
strategy
    using row_number() window function to mark the order of event
    use count(*) window function to with partioin but not with order to 
    filter (1, 2) to find result
note
    window function do not collapse data point to compute aggregation
    same row with the same key in partition and order will get the same result
    window function can be use to compute rank, sequence or aggregatioin
*/
SELECT username, activity, startDate, endDate
FROM (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY username ORDER BY endDate DESC) AS r,
        -- do not 
        COUNT(*) OVER (PARTITION BY username) AS c
    FROM UserActivity
) tb1
WHERE r = 2 OR c = 1;