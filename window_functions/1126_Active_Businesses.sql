/*
problem:
    events (business_id, event_type, occurence). primary (business_id+event_type)
    ==> find all active business
        active business have more than one event type which occurence greater than average
strategy
    compute all business average for each type using window function
    find active business
notes:
    one business can have muliple active type
*/
with temp as (
    select * 
    , avg(occurences) over(partition by event_type) as all_avg
    from events
)
select 
business_id
from temp
group by business_id
having count(if(occurences > all_avg, 1, 0)) > 1