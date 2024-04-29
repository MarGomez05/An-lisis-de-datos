-- EJERCICIO #1 
SELECT title, rental_rate, replacement_cost
FROM film
WHERE replacement_cost < 4 * rental_rate;


--EJERCICIO #2
SELECT title
FROM    film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category ca ON ca.category_id = fc.category_id 
WHERE release_year = 2006
    AND rental_rate between 0.99 and 2.99 
    AND replacement_cost < 19.99 
    AND length between 90 and 150
    AND rating IN ('G', 'PG', 'PG-13')
    AND rental_duration <= 5
    AND UPPER (ca.name) IN ('COMEDY', 'FAMILY', 'CHILDREN');


--EJERCICIO #3
SELECT 
    TO_CHAR(rental.rental_date, 'DD-MON-YYYY') AS "Fecha de Renta",
    TO_CHAR(rental.rental_date, 'HH24:MI') AS "Hora de Renta",
    film.title AS "Título",
    CONCAT(customer.first_name, ' ', customer.last_name) AS "Nombre del Cliente",
    customer.email AS "Email del Cliente",
    CONCAT(address.address, '. ', city.city, ', ', address.postal_code, '. ', country.country) AS "Dirección Completa del Cliente",
    address.phone AS "Teléfono del Cliente",
    CONCAT(staff.first_name, ' ', staff.last_name) AS "Nombre del Empleado"
FROM 
    rental
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film ON inventory.film_id = film.film_id
JOIN 
    customer ON rental.customer_id = customer.customer_id
JOIN 
    staff ON rental.staff_id = staff.staff_id
JOIN 
    address ON customer.address_id = address.address_id
JOIN 
    city ON address.city_id = city.city_id
JOIN 
    country ON city.country_id = country.country_id
WHERE 
    DATE(rental.rental_date) = '2005-07-31'
ORDER BY 
    rental.rental_date ASC;




--EJERCICIO #4
SELECT
    TO_CHAR(rental.rental_date, 'YYYY-MM-DD HH24:MI:SS') AS "Fecha y hora de renta",
    CONCAT(customer.first_name, ' ', customer.last_name) AS "Nombre completo del cliente",
    customer.email AS "Email del cliente",
    address_customer.phone AS "Teléfono del cliente",
    country_customer.country AS "País de residencia del cliente",
    CONCAT(staff.first_name, ' ', staff.last_name) AS "Nombre completo del empleado",
    staff.email AS "Email del empleado",
    address_staff.phone AS "Teléfono del empleado",
    country_staff.country AS "País de residencia del empleado"
FROM
    rental
JOIN
    customer ON rental.customer_id = customer.customer_id
JOIN
    address AS address_customer ON customer.address_id = address_customer.address_id
JOIN
    city AS city_customer ON address_customer.city_id = city_customer.city_id
JOIN
    country AS country_customer ON city_customer.country_id = country_customer.country_id
JOIN
    staff ON rental.staff_id = staff.staff_id
JOIN
    address AS address_staff ON staff.address_id = address_staff.address_id
JOIN
    city AS city_staff ON address_staff.city_id = city_staff.city_id
JOIN
    country AS country_staff ON city_staff.country_id = country_staff.country_id
WHERE
    rental.rental_date::date = '2005-05-25';


--EJERCICIO #5
SELECT 
    rental.rental_id,
    rental.rental_date,
    film.title AS "Título de la Película",
    film.rental_rate AS "Tarifa de Renta",
    payment.amount AS "Monto Pagado"
FROM 
    rental
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film ON inventory.film_id = film.film_id
JOIN 
    payment ON rental.rental_id = payment.rental_id
WHERE 
    EXTRACT(MONTH FROM rental.rental_date) = 8 -- Agosto
    AND EXTRACT(YEAR FROM rental.rental_date) = 2005 -- Año 2005
    AND film.rental_rate <> payment.amount
ORDER BY 
    rental.rental_date;


