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
          , dense_rank() over(order by salary desc) as rnk
          from employee
      )
      select distinct salary as getNthHighestSalary
      from temp
      where rnk = N
  );
END