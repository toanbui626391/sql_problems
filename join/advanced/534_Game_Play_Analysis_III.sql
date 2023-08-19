/*
problem
    activity (player_id, device_id, event_date, games_played). key player_id, event_date
    ==> game play so far for each player and date
strategy
    using widow function to compute running sum
    if player_id + event_date is not primary key we need to select distinct to remove duplicate data
*/
select
distinct player_id
, event_date
. sum(games_played) over(player_id order by event_date) as games_played_so_far
from activity
