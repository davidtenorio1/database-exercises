--Create a file named 3.9_temporary_tables.sql to do your work for this exercise.
--Using the example from the lesson, re-create the employees_with_departments table.
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

--Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(31);

--Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

--Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;

--What is another way you could have ended up with this same table?
Could have used concat in the creation of the table instead of having separate columns for first name and last name.
--Create a temporary table based on the payment table from the sakila database.
CREATE TEMPORARY TABLE payments AS
SELECT *
FROM sakila.payment
LIMIT 100;

--Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
alter table payments add cent_amount int unsigned;
update payments set cent_amount = amount * 100;

--Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?


--What is the average salary for an employee based on the number of years they have been with the company? Express your answer in terms of the Z-score of salary.
--Since this data is a little older, scale the years of experience by subtracting the minumum from every row.



