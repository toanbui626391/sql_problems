/*
problem: 1336. Number of Transactions per Visit
  compute number of visit for each visit category
learning:
  understand the problem that we have to compute number of transaction per visit and then compute number of visit for each transaction number category
  how to generate positive integer sequence and then filter unwanted sequence
    this problem come from that aggregate category may not in a sequence but we must present as a sequence
*/

WITH T AS (
  -- generate sequence of number of category of visited
SELECT ROW_NUMBER() OVER() row_num
FROM Transactions
UNION 
SELECT 0
), 
T1 as (
  -- compute number of transaction per visite(user_id, visit_date)
SELECT COUNT(transaction_date) transaction_count
FROM Visits v
LEFT JOIN Transactions t
ON v.user_id = t.user_id
AND v.visit_date = transaction_date
GROUP BY v.user_id, v.visit_date
)
-- compute number of visit for each type of transactions
SELECT row_num transactions_count, COUNT(transaction_count) visits_count
FROM T
LEFT JOIN T1
ON row_num = transaction_count
GROUP BY row_num
HAVING row_num <= (SELECT MAX(transaction_count) FROM T1) -- filter out the unwanted sequence
ORDER BY row_num