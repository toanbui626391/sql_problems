select min(abs(p2.x-p1.x)) as shortest
from point as p1
left join point as p2 on p1.x != p2.x