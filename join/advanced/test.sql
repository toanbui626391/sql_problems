/*
problem
    teams (team_id, team_name)
    matches (match_id, host_team, guest_team, host_scores, quest_scores)
    => calculate team score with given rule
note:
    sql execution sequence: join -> filter -> group by -> order
*/
select 
t.team_id
, t.team_name
, sum(
    case 
        when t.team_id = m.host_team and m.host_goals > m.guest_goals then 3
        when t.team_id = m.guest_team and m.guest_goals > m.host_goals then 3
        when m.host_goals = m.guest_goals then 1
        else 0
    end
) as num_points
from teams as t
left join matches as m on t.team_id = m.host_team or t.team_id = guest_team
group by t.team_id, t.team_name
order by num_points desc, team_id asc