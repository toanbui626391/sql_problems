/*
problem
    student(name, continent)
    => pivot, student name asc
strategy

*/
with temp as (
    select
    row_number() over(partition by continent order by name) as rnb
    , if(continent="America", name, null) as America
    , if(continent="Asia", name, null) as Asia
    , if(continent="Europe", name, null) as Europe
    from student
)
select
-- only one cell in rnb group have value other is null
min(America) as America
, min(Asia) as Asia
, min(Europe) as Europe
from temp
group by rnb
