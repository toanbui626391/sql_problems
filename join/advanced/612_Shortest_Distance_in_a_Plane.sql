/*
problem
    point_2d (x, y)
    => find shortest distance
strategy
*/
select 
min(round(sqrt(power(p2.x-p1.x, 2) + power(p2.y-p1.y, 2)))) as shortest
from point_2d as p1
-- one point have connection with n-1 point, they just need to different by either x, or y to be different points
left join point_2d as p2 on p1.x != p2.x or p1.y != p2.y