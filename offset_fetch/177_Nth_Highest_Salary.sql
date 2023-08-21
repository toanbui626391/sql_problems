/*
strategy
    use dense_rank() to do not missing the nth data point
    use max(), min() after filter to return null if do not have the nth data point
*/
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      with temp as (
        select * 
        , dense_rank() over(order by salary desc) as drnk
        from employee
      )
      select max(salary) as SecondHighestSalary
      from temp
      where drnk = N
      
  );
END