--Create a file named 3.8.3_subqueries_exercises.sql and craft queries to return the results for the following criteria:
--Find all the employees with the same hire date as employee 101010 using a sub-query.
--69 Rows
select concat(employees.first_name, " ", employees.last_name) as Employee_Name, employees.hire_date
from employees
where employees.hire_date in
(select employees.hire_date
from employees
where emp_no = '101010');

--Find all the titles held by all employees with the first name Aamod.
--314 total titles, 6 unique titles
select title
from titles
where titles.emp_no in 
(select emp_no 
from employees 
where employees.first_name = 'Aamod');

--How many people in the employees table are no longer working for the company?
select count(*)
from employees
where employees.emp_no not in
(select dept_emp.emp_no
from dept_emp
where dept_emp.to_date = '9999-01-01');

--Find all the current department managers that are female.

select employees.first_name, employees.last_name
from dept_manager
join employees on dept_manager.emp_no = employees.emp_no
where  dept_manager.to_date = '9999-01-01' 
and dept_manager.emp_no in
(select employees.emp_no
from employees
where employees.gender = 'F');

--Find all the employees that currently have a higher than average salary.
--154543 rows in total. Here is what the first 5 rows will look like:

--How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
--78 salaries