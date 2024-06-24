/*
problem: 1097. Game Play Analysis V
    compute Day1_retention value
learning
  how to use rank and lead to mark the install day and the date after install date
  run step by step to debug for complex query
  lead arrange the next row value to the current row value
  sum / sum is syntax error in mysql
*/
-- mark install date, mark login at the date after login
-- compute install by date
with temp as (
    select * 
    , row_number() over(partition by player_id order by event_date asc) as rnb
    , datediff(lead(event_date, 1) over(partition by player_id order by event_date asc), event_date) as date_mark
    from Activity
), 
temp2 as (
    select event_date as install_dt
    , sum(if(rnb=1, 1, 0)) as installs
    , sum(if(rnb=1 and date_mark=1, 1, 0)) as Day1_retention
    from temp
    group by event_date
)
select install_dt
, installs
, round(Day1_retention / installs, 2) as Day1_retention
from temp2
where installs >= 1


