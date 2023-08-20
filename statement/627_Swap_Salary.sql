/*
problem:
    salary(id, name, sex, salary): salary for each eployee
    => change sex f to m and m to f
strategy
    using update statement
        update statement do not have from keyword. Just update table_name
*/
UPDATE salary
SET sex = CASE WHEN sex = 'm' THEN 'f' ELSE 'm' END;