--Employees Database
--How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
'Production manager and customer service manager are paid less than average of their respected departments.'
use employees;
select dept_name, employees.first_name, employees.last_name, salary
from salaries
join dept_manager using (emp_no)
join dept_emp using (emp_no)
join departments on departments.dept_no = dept_emp.dept_no
join employees using (emp_no)
where dept_manager.to_date > now() and salaries.to_date > now()
order by dept_name;

select dept_name, avg(salary)
from salaries
join employees using (emp_no)
join dept_emp using (emp_no)
join departments using (dept_no)
where dept_emp.to_date > now() and salaries.to_date > now()
group by dept_name;

--Use the world database for the questions below.
--What languages are spoken in Santa Monica?
use world; 
select language, percentage
from countrylanguage
where countrycode like 'usa'
order by percentage;

--How many different countries are in each region?
use world; 
select region, count(region)
from country
group by region
order by count(region);

--What is the population for each region?
use world; 
select region, sum(population)
from country
group by region
order by sum(population) desc;

--What is the population for each continent?

use world; 
select continent, sum(population)
from country
group by continent
order by sum(population) desc;