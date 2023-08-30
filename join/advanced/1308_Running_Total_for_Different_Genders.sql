/*
problem
    score (player_name, gender, day, score_points)
    => write query to find running total_score for each gener at each day. order by gener and date
strategy
    commpute running sum using sum window function
    sum(score_points) over(partition by gener order by day) as total
note:
    window function, partion by is device data into groups
    by default computing window will expend from the first row to the current row => therefore, we have running sum from start to current row
*/
SELECT DISTINCT gender, day,
    SUM(score_points) OVER (PARTITION BY gender ORDER BY day) AS total
FROM Scores
ORDER BY gender, day;