--EMPLOYEES DATABASE

--How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
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





--WORLD DATABASE

--What languages are spoken in Santa Monica?
use world; 
select language, percentage
from countrylanguage
where countrycode like 'usa'
order by percentage;

--How many different countries are in each region?
select region, count(region)
from country
group by region
order by count(region);

--What is the population for each region?
select region, sum(population)
from country
group by region
order by sum(population) desc;

--What is the population for each continent? 
select continent, sum(population)
from country
group by continent
order by sum(population) desc;

--What is the average life expectancy globally?
select avg(lifeexpectancy)
from country;

--What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
select continent, avg(lifeexpectancy)
from country
group by continent
order by avg(lifeexpectancy);

select region, avg(lifeexpectancy)
from country
group by region
order by avg(lifeexpectancy);

--BONUS
--Find all the countries whose local name is different from the official name
select name
from country
where name <> localname;

--How many countries have a life expectancy less than 65?
select count(name)
from country
where lifeexpectancy < 65;

--What state is Tigre located in?
select district
from city
where city.name like 'Tigre';

--What region of the world is Tigre located in?
select country.region
from country
join city on city.countrycode = country.code
where city.name like 'Tigre';

--What country (use the human readable name) is Tigre located in?
select country.name
from country
join city on city.countrycode = country.code
where city.name like 'Tigre';

--What is the life expectancy in Tigre?
select lifeexpectancy
from country
join city on 
city.countrycode = country.code
where city.name like 'Tigre';





--SAKILA DATABASE

--Display the first and last names in all lowercase of all the actors.
use sakila;
select lower(first_name) as First_name, lower(last_name) as Last_name
from actor;

--You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?
select actor_id, first_name, last_name
from actor
where first_name like 'joe';

--Find all actors whose last name contain the letters "gen":
select actor_id, first_name, last_name
from actor
where last_name like '%gen%';

--Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
select actor_id, first_name, last_name
from actor
where last_name like '%li%'
order by last_name, first_name;

--Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
select country_id, country
from country 
where country in ('Afghanistan', 'Bangladesh', 'China');

--List the last names of all the actors, as well as how many actors have that last name.
select last_name as actor_last_name, count(last_name) as number_of_actors
from actor
group by last_name;

--List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name as actor_last_name, count(last_name) as number_of_actors
from actor
group by last_name having number_of_actors > 1
order by number_of_actors;

--You cannot locate the schema of the address table. Which query would you use to re-create it?
create temporary table new_address_table
(select * from sakila.address);

--Use JOIN to display the first and last names, as well as the address, of each staff member.
select first_name, last_name, address
from staff
join address using (address_id);

--Use JOIN to display the total amount rung up by each staff member in August of 2005.
select staff_id, first_name, last_name, sum(amount)
from staff
join payment using (staff_id)
where payment_date >= '2005-08-01' and payment_date <= '2005-08-31'
group by staff_id;

--List each film and the number of actors who are listed for that film.
select title, count(title) as number_of_actors
from film
join film_actor using (film_id)
group by (title);

--How many copies of the film Hunchback Impossible exist in the inventory system?
select title, count(title) as inventory
from film
join inventory using (film_id)
group by (title)
having title like 'HUNCHBACK IMPOSSIBLE';

--The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
select title, language.name as language
from film
join language using (language_id)
where title like 'q%' or  title like 'k%' and
title in
(select title
from film 
where language_id = '1');

--Use subqueries to display all actors who appear in the film Alone Trip.




