--Create a new file named 3.7_group_by_exercises.sql
--In your script, use DISTINCT to find the unique titles in the titles table.
select distinct title from titles;

--Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY.
select last_name from employees where last_name like 'e%e'
group by last_name;

--Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.
select first_name,last_name from employees where last_name like 'e%e'
group by last_name,first_name;

--Find the unique last names with a 'q' but not 'qu'. 
select last_name from employees where last_name like '%q%' and last_name not like '%qu%'
group by last_name;

--Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
select last_name, count(last_name) from employees
where last_name like '%q%' and last_name not like '%qu%'
group by last_name
order by count(last_name);

--Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. 
select count(*),gender from employees where first_name in ('Irena', 'Vidya', 'Maya')
group by gender;

--Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?
Yes, there are duplicate usernames

--Bonus: how many duplicate usernames are there?
14,152