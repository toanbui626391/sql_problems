/*
problem:
    activity (player_id, device_id, event_date, games_played). primary key : player_id, event_date
    => compute cummulative sum for each player and date
strategy
    using sum window function, we already have primary key is player_id + event_date
*/
select 
player_id
, event_date
, sum(games_played) over(partition by player_id order by event_date) as games_played_so_far
from activity