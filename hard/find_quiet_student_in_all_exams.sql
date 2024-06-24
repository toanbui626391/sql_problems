/*
problem: 1412. Find the Quiet Students in All Exams
    find quiest student in all exame. quiet student is who not get highest or lowest score for any other test
learning:
  using rank() to mark student which is higtest or lowest store in each exam
  filter to find student which do not have any highest or lowest score
  for aggregate filter we can use having
    having()
*/
with temp as (
    -- rank student by exam type
    select e.student_id as student_id
    , s.student_name as student_name
    , rank() over(partition by e.exam_id order by e.score desc) as rnk_desc
    , rank() over(partition by e.exam_id order by e.score asc) as rnk_asc
    from Exam as e
    left join Student as s
    on e.student_id = s.student_id
)
select distinct student_id
, student_name
from temp
where student_id not in (
    select student_id from temp where rnk_desc = 1 or rnk_asc = 1
)
order by student_id

-- Solution using having to filter base on aggregate condition
/*
problem:
    find quiest student in all exame. quiet student is who not get highest or lowest score for any other test
*/
with temp as (
    -- rank student by exam type
    select e.student_id as student_id
    , s.student_name as student_name
    , rank() over(partition by e.exam_id order by e.score desc) as rnk_desc
    , rank() over(partition by e.exam_id order by e.score asc) as rnk_asc
    from Exam as e
    left join Student as s
    on e.student_id = s.student_id
)
select student_id
, student_name
from temp
group by student_id, student_name
having sum(if(rnk_desc = 1 or rnk_asc = 1, 1, 0)) = 0 -- student which do not have any low or high
order by student_id

