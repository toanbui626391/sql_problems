/*
problem
    enrollments (student_id, course_id, grade). primary key (student_id + course_id)
    ==>find course which have highest grade for each student
        if tie choose smaller course id
        sorted by increasing student_id
strategy
    using window function to rank course which grade for each student
    filter rank to get rsult
*/
with temp as (
    select *
    -- if tie choose smaller course_id
    , rank() over(partition by student_id order by grade desc, course_id asc) as rnk
    from enrollments
)
select
student_id
, course_id
, grade
from temp
where rnk = 1
order by student_id asc