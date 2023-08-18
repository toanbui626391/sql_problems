/*
problem
    teams (team_id, team_name)
    matches (match_id, host_team, guest_team, host_goal, guest_goal)
solution
    calculate score for host_team, guest_team at each match
        using join betweeten teams left join matches on t.team_id = m.host_team or t.team_id = m.guest_team
        relation one-many, and with or condition so we will have row for host_team and guest_team
        number of rows is two time of match rows
    after join we can calculate score for host_team and guest_team using using case when then for complext logical test
*/
SELECT team_id, team_name,
    SUM(
        CASE WHEN team_id = host_team AND host_goals > guest_goals THEN 3
             WHEN team_id = guest_team AND guest_goals > host_goals THEN 3
             WHEN host_goals = guest_goals THEN 1
             ELSE 0
        END          
    ) AS num_points
FROM Teams t
LEFT JOIN Matches m 
ON t.team_id = m.host_team OR t.team_id = m.guest_team
GROUP BY team_id, team_name
ORDER BY num_points DESC, team_id;