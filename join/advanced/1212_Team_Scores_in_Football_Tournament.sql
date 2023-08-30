# Write your MySQL query statement below
/*
problem
    teams (team__id, team_name)
    matches (match_id, host_team, guest_team, host_goals, guest_goals)
    => compute team score and order it score desc if tie team_id asc
strategy
    join between teams and matches to get score for each tem
*/
select 
t.team_id as team_id
, t.team_name as team_name
, ifnull(sum(
    case
        when t.team_id = m.host_team and host_goals > guest_goals then 3
        when t.team_id = m.guest_team and host_goals < guest_goals then 3
        when host_goals = guest_goals then 1
        else 0
    end
), 0) as num_points
from teams as t
left join matches as m on t.team_id = m.host_team or t.team_id = m.guest_team
group by t.team_id, t.team_name 
order by num_points desc, team_id asc