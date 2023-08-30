/*
problem:
    salary(id, name, sex, salary): salary for each eployee
    => change sex f to m and m to f
strategy
    using update statement
        update statement do not have from keyword. Just update table_name
*/
update salary
set sex = if(sex="m", "f", "m")