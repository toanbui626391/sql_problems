    /*
    problem
        employee (id, name, salary). primary key id
        department (id, name). primary key: id
        => find top3 unique highest salary
    strategy
        use dense_rank
        filte
    */
    with temp as (
        select 
        d.name as Department
        , e.name as Employee
        , e.salary as Salary
        , dense_rank() over(partition by e.departmentId order by e.salary desc) as rnk
        from employee as e
        left join department as d on e.departmentId = d.id
    )
    select Department, Employee, Salary
    from temp
    where rnk <= 3