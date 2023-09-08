/*
problem
    student (student_id, student_name), primary key student_id
    exam (exam_id, student_id, score), primary key: exam_id, student_id
    => find quiet student
        attend at least one exam
        neither highest or lowest score for each exam
strategy
    using rank to find student which is not get highest or lowest score in each exam
    using count to count number of exam student attend
    filter
*/
with temp as (
    select s.student_id as student_id, s.student_name as student_name
    , rank() over(partition by e.exam_id order by e.score desc) as rnk_desc
    , rank() over(partition by e.exam_id order by e.score asc) as rnk_asc
    , count(e.exam_id) over(partition by s.student_id) as cnt
    from student as s
    left join exam as e on s.student_id = e.student_id
)
select student_id, student_name
from student
where student_id not in (
    select student_id from temp
    where rnk_desc = 1 or rnk_asc = 1 or cnt < 1
)