use mavenmovies;

show tables;
select * from actor;
select * from actor_award;
select * from address;
select * from country;
select * from film_actor;
select * from film;

/* managers of each store, full address of each property*/
select * from staff;
select * from address;
select * from city;
select * from country;
select * from store;
select staff.first_name as managerfirstname, staff.last_name as managerlastname,
       address.address, address.district, city.city, country.country
from store
       left join staff on store.manager_staff_id = staff.staff_id
       left join address on staff.address_id = address.address_id
       left join city on address.city_id = city.city_id
       left join country on city.country_id = country.country_id


/*
   get the list of all inventory items stocked including store_id number,
   the inventory_id, the name of the film, films rating, rental rate and replacement cost
*/
select * from inventory; /* inventory id, film id, store_id, last update */
select * from store; /* store id, manager_staff_id, address_id, last_update */
/*
film_id, title, description, release_year, language_id, original_language_id, rental_duration
rental_rate, length, repplacement_cost, rating, special_features, last_updates
*/
select * from film;

select inventory.store_id, inventory.inventory_id, film.title, film.rating, film.rental_rate, film.replacement_cost
       from inventory left join film on inventory.film_id = film.film_id;

/* summary level overview of inventory. how many inventory items you have with each rating at each store */
select * from inventory; /* inventory id, film id, store_id, last update */
/*
film_id, title, description, release_year, language_id, original_language_id, rental_duration
rental_rate, length, replacement_cost, rating, special_features, last_updates
*/
select * from film;

select inventory.store_id, film.rating, count(inventory_id) as inventory_items from inventory
    left join film on inventory.film_id = film.film_id
    group by inventory.store_id, film.rating;

/* get to know more about the inventory, store_id, film categories, average replacement cost, total replacement cost*/
select store_id, category.name as category, count(inventory.inventory_id) as films,
       avg(film.replacement_cost) as avg_replacement_cost, sum(film.replacement_cost) as total_replacement_cost
       from inventory left join film on inventory.film_id = film.film_id
                      left join film_category on film.film_id = film_category.film_id
                      left join category on category.category_id = film_category.category_id
       group by store_id, category.name
       order by sum(film.replacement_cost) desc;

/* get all the customer data */
select customer.first_name, customer.last_name, customer.store_id, customer.active, address.address, city.city, country.country
        from customer left join address on customer.address_id = address.address_id
                      left join city on address.city_id = city.city_id
                      left join country on city.country_id = country.country_id;

/**/
select customer.first_name, customer.last_name, count(rental.rental_id) as total_rentals,
       sum(payment.amount) as total_payment_amount
       from customer left join rental on customer.customer_id = rental.customer_id
                     left join payment on rental.rental_id = payment.rental_id
       group by customer.first_name, customer.last_name
       order by sum(payment.amount) desc;

/**/

select 'investor' as type, first_name, last_name, company_name from investor
       union select 'advisor' as type, first_name, last_name, NULL from advisor;

/**/

SELECT
	CASE
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END AS number_of_awards,
    AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film

FROM actor_award


GROUP BY
	CASE
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END

/* 2 HOURS TO WORK ON IT TOMORROW */




