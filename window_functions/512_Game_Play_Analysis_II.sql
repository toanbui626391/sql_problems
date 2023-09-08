/*
problem
    activity (player_id, device_id, event_date, games_played)
    => device which is first logged in for each player
strategy
    using rank to find first device logged in by each player
*/
with temp as (
    select * 
    , rank() over(partition by player_id order by event_date) as rnk
    from activity
)
select player_id, device_id
from temp 
where rnk = 1