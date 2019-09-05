--Use the join_example_db. Select all the records from both the users and roles tables.
select * from users, roles;
--Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT users.name as user_name, roles.name as role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

--Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

--Use the employees database.
use employees;

--Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
select CONCAT(employees.first_name, ' ', employees.last_name) AS full_name,
departments.dept_name as Department_Name
from departments
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees on employees.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date = '9999-01-01'
order by department_name;

--Find the name of all departments currently managed by women.
select CONCAT(employees.first_name, ' ', employees.last_name) AS full_name,
departments.dept_name as Department_Name
from departments
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees on employees.emp_no = dept_manager.emp_no
where dept_manager.to_date = '9999-01-01' and employees.gender = 'F'
order by department_name;

--Find the current titles of employees currently working in the Customer Service department.
select titles.title, count(dept_emp.emp_no)
from titles
join dept_emp on titles.emp_no = dept_emp.emp_no
join departments on departments.dept_no = dept_emp.dept_no
where titles.to_date = '9999-01-01' and dept_emp.to_date = '9999-01-01' and departments.dept_name = 'Customer Service'
group by (title);

--Find the current salary of all current managers.
select departments.dept_name as Department_Name, CONCAT(employees.first_name, ' ', employees.last_name) AS full_name, salaries.salary
from departments
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees on employees.emp_no = dept_manager.emp_no
join salaries on salaries.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date = '9999-01-01' and salaries.to_date = '9999-01-01'
order by department_name;

--Find the number of employees in each department.