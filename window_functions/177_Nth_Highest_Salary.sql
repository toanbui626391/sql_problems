/*
problem:
    employee (id, salary)
strategy
    use dense_rank to find the nth salary
    use distinct to choose in case we have multiple data poin which have the same rank. it also return null when empty result
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