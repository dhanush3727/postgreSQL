-- Order By
SELECT * FROM 
orders
ORDER BY product ASC;

SELECT * FROM orders
ORDER BY customer_id ASC, product DESC;

-- Order by with join
SELECT c.name, o.product
FROM customer c
JOIN orders o ON c.id = o.customer_id
ORDER BY c.name ASC;

-- Order by with group by
SELECT customer_id, COUNT(*) AS total
FROM orders
GROUP BY customer_id
ORDER BY customer_id ASC;

-- Limit and Offset
SELECT * from orders
LIMIT 3
OFFSET 2;

SELECT * FROM orders
ORDER BY id DESC
LIMIT 3;
