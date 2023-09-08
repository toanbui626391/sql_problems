/*
problem
    weather (id, recordDate, temperature)
    => find id of date which is higher than previous date
strategy
    lag to get temp of yesterday
    compare and then filter
*/

select w.id as id
from weather as w
left join weather as w1 on date_add(w.recordDate, interval -1 day) = w1.recordDate
where w.temperature > w1.temperature

