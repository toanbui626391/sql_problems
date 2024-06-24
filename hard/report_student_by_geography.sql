/*
problem
    student (name, continent)
    => pivot report, 
learning:
  using row number of mark number of row in collapsing table
  using if to get name for each geography
  using min to find the name of aggregated group(rnb) and for each geography
    return min value of have non null value
    return null if all null value
*/
with temp as (
    select * 
    , row_number() over(partition by continent order by name) as rnb
    , if(continent =  "America", name, null) as America
    , if(continent = "Asia", name, null) as Asia
    , if(continent = "Europe", name, null) as Europe
    from student
)
select
min(America) as America, min(Asia) as Asia, min(Europe) as Europe -- min to remove null
from temp
group by rnb