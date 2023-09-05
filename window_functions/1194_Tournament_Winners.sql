/*
problem
    players (player_id, group_id)
    matches (match_id, first_player, second_player, first_score, second_score)
    => find winner in each groupp
            if tie lower player id is winner
strategy
    use union_all to get player and their score form matches
    aggregate to compute total score for each player in each group
    rank player in group
    filter the winner
*/
#compute total score for each player
with temp as (
    select 
    p.player_id as player_id
    , p.group_id as group_id
    , sum(if(p.player_id = first_player, first_score, second_score)) as total_score
    from players as p
    left join matches as m on p.player_id = m.first_player or p.player_id = m.second_player
    group by group_id, player_id
),
temp2 as (
    select 
    group_id, player_id
    , rank() over(partition by group_id order by total_score desc, player_id asc) as rnk
    from temp
)
select group_id, player_id
from temp2
where rnk = 1
