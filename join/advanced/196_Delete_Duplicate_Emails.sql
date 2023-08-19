/*
problem: 
    person (id, email)
    ==> delete duplicte email from person table
strategy
    using row_number() window function to makr duplicate email
    use delete statement delete from table where <condition> to delete data poin which is duplicated
*/
with temp as (
    select *
    , row_number() over(partition by email order by id) as rnb
    from person
)
delete
from person
where id in (
    select id from temp where rnb > 1
)