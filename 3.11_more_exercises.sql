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
select first_name, last_name
from actor
where actor_id in
(select actor_id
from film_actor
join film using (film_id)
where title like 'Alone Trip');

--You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
select first_name, last_name, email
from customer
join address using (address_id)
join city using (city_id)
join country using (country_id)
where country like 'Canada';

--Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
select title
from film
join film_category using(film_id)
join category using(category_id)
where name like 'Family';

--Write a query to display how much business, in dollars, each store brought in.
select store_id, sum(amount) as business_by_dollar_amount
from payment
join store on store.manager_staff_id = payment.staff_id
group by store_id;

--Write a query to display for each store its store ID, city, and country.
select store_id, city, country
from store
join address using(address_id)
join city using(city_id)
join country using(country_id);

--List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select name as Genre, sum(amount) as Gross_Revenue
from payment
join rental using(rental_id)
join inventory using(inventory_id)
join film_category using (film_id)
join category using(category_id)
group by name
order by sum(amount) desc
limit 5;



--SELECT Statements
--Select all columns from the actor table.
select * from actor;

--Select only the last_name column from the actor table.
select last_name from actor;

--Select only the following columns from the film table.
select * from film;



--DISTINCT Operator
--Select all distinct (different) last names from the actor table.
select distinct last_name from actor;

--Select all distinct (different) postal codes from the address table.
select distinct postal_code from address;

--Select all distinct (different) ratings from the film table.
select distinct rating from film;



--WHERE Clause
--Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
select title, description, rating, length
from film
where length >= 180;

--Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
select payment_id, amount, payment_date
from payment
where payment_date >= '2005-5-27';

--Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
select payment_id, amount, payment_date
from payment
where payment_date > '2005-05-27 00:00:00' and payment_date < '2005-05-28 00:00:00';

--Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
select *
from customer
where last_name like "s%" and first_name like "%n";

--Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
select *
from customer
where active = '0' and last_name like "m%";

--Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
select *
from category
where (name like "c%" or name like "s%" or name like "t%") and category_id > 4;

--Select all columns minus the password column from the staff table for rows that contain a password.
select staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
from staff
where password is not null;

--Select all columns minus the password column from the staff table for rows that do not contain a password.
select staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
from staff
where password is null;



--IN Operator
--Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
select phone, district
from address
where district in ('California', 'Taipei', 'England', 'West Java');

--Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
select payment_id, amount, payment_date
from payment
where date(payment_date) in ('2005-05-25','2005-05-27','2005-05-29');

--Select all columns from the film table for films rated G, PG-13 or NC-17.
select *
from film
where rating in ('G', 'PG-13', 'NC-17');




--BETWEEN Operator
--Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
select *
from payment
where payment_date between '2005-05-25 00:00:00' and '2005-05-25 23:59:59';

--Select the following columns from the film table for films where the length of the description is between 100 and 120.
--Hint: total_rental_cost = rental_duration * rental_rate
select *
from film
where char_length(description) between 100 and 120; 




--LIKE Operator
--Select the following columns from the film table for rows where the description begins with "A Thoughtful".
 select *
from film
where description like "A Thoughtful%";

--Select the following columns from the film table for rows where the description ends with the word "Boat".
select *
from film
where description like "%boat";

--Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
select *
from film
where description like "%database%" and length >180;




--LIMIT Operator
--Select all columns from the payment table and only include the first 20 rows.
select *
from payment
limit 20;

--Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
select payment_date, amount
from payment
where amount > 5
and payment_id between 1000 and 2000

--Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
select *
from customer
limit 100 offset 100;




--ORDER BY statement
--Select all columns from the film table and order rows by the length field in ascending order.
select *
from film
order by length;

--Select all distinct ratings from the film table ordered by rating in descending order.
select distinct rating
from film
order by rating desc;

--Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
select payment_date, amount
from payment
order by amount desc
limit 20;

--Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
select title, description, special_features, length, rental_duration
from film
where special_features like "%behind%"
and length <120
and rental_duration >= 5 and rental_duration <=7
order by length desc
limit 10;




--Joins
--Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
select customer.first_name, customer.last_name, actor.first_name, actor.last_name
from customer
left join actor
on customer.last_name = actor.last_name;

--Label customer first_name/last_name columns as customer_first_name/customer_last_name
select customer.first_name as customer_first_name, customer.last_name as customer_last_name, actor.first_name, actor.last_name
from customer
left join actor
on customer.last_name = actor.last_name;

--Label actor first_name/last_name columns in a similar fashion.
select customer.first_name as customer_first_name, customer.last_name as customer_last_name, actor.first_name as actor_first_name, actor.last_name as actor_last_name
from customer
left join actor
on customer.last_name = actor.last_name;
--returns correct number of records: 620

--Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
select customer.first_name as customer_first_name, customer.last_name as customer_last_name, actor.first_name as actor_first_name, actor.last_name as actor_last_name
from customer
right join actor
on customer.last_name = actor.last_name;

--Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
select customer.first_name as customer_first_name, customer.last_name as customer_last_name, actor.first_name as actor_first_name, actor.last_name as actor_last_name
from customer
join actor
on customer.last_name = actor.last_name;

--Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
select city, country
from city
left join country
on city.country_id = country.country_id;

--Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
select title, description, release_year, name as language
from film
left join language
on language.language_id = film.language_id


--Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
select first_name, last_name, address, address2, city, district, postal_code
from staff
join address
on address.address_id = staff.address_id
join city
on city.city_id = address.city_id;




--What is the average replacement cost of a film? Does this change depending on the rating of the film?
"Average replacement cost is 19.98. It varies slightly by moving rating with PG being cheaper than average."
select avg(replacement_cost)
from film;

select rating, avg(replacement_cost)
from film
group by rating;

--How many different films of each genre are in the database?
select name, count(film_id)
from film
join film_category using (film_id)
join category using (category_id)
group by name;

--What are the 5 frequently rented films?
select title, count(title) as number_of_rentals
from rental
join inventory using (inventory_id)
join film using (film_id)
group by title desc
order by number_of_rentals desc
limit 5;

--What are the most most profitable films (in terms of gross revenue)?
select title, sum(amount) as gross_revenue
from payment
join rental using (rental_id)
join inventory using (inventory_id)
join film using (film_id)
group by title
order by gross_revenue desc
limit 5;

--Who is the best customer?







