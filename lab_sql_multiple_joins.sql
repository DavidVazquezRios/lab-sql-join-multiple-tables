use sakila;
#1. Write a query to display for each store its store ID, city, and country.
SELECT 
    A.store_id, B.city, C.country
FROM
    store A
        JOIN
    address  USING (address_id)
        JOIN
    city B USING (city_id)
        JOIN
    country C USING (country_id)
;
#2. Write a query to display how much business, in dollars, each store brought in.
SELECT 
    A.store_id, SUM(B.amount) AS total
FROM
    store A
        LEFT JOIN
    staff USING (store_id)
        LEFT JOIN
    payment B USING (staff_id)
GROUP BY A.store_id
;
#3. What is the average running time of films by category?
SELECT 
    C.name, round(AVG(A.length)) AS average
FROM
    film A
        JOIN
    film_category B USING (film_id)
        JOIN
    category C USING (category_id)
GROUP BY C.name
;

#4. Which film categories are longest?
SELECT 
    C.name, AVG(A.length) AS average
FROM
    film A
        JOIN
    film_category B USING (film_id)
        JOIN
    category C USING (category_id)
GROUP BY C.name
ORDER BY average DESC;

#5. Display the most frequently rented movies in descending order.
SELECT 
    C.title, count(*) AS frecuency
FROM
    rental A
        JOIN
    inventory B USING (inventory_id)
        JOIN
    film C USING (film_id)
GROUP BY C.title
ORDER BY frecuency DESC;



#6. List the top five genres in gross revenue in descending order.
SELECT 
    A.name, COUNT(B.amount) AS revenue
FROM
    category A
        LEFT JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment B USING (customer_id)
GROUP BY A.name
ORDER BY revenue DESC
LIMIT 5;

#7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    C.store_id,
    A.title,
    CASE
        WHEN B.inventory_id = 0 THEN 'False'
        ELSE 'True'
    END AS available
FROM
    film A
        LEFT JOIN
    inventory B USING (film_id)
        JOIN
    store C USING (store_id)
WHERE
    A.title = 'Academy Dinosaur'
GROUP BY C.store_id , A.title
HAVING C.store_id = 1
;
