with temp as (
    select
    requester_id as person
    from requestaccepted
    union all
    select
    accepter_id as person
    from requestaccepted
),
temp2 as (
    select person
    , count(*) as cnt
    from temp
    group by person
),
temp3 as (
    select *
    , max(cnt) over() as max_cnt
    from temp2
)
select
person as id
,cnt as num
from temp3
where cnt = max_cnt