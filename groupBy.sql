-- Group By
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 2;

-- Group by with join
SELECT c.name, COUNT(*) AS total_orders
FROM customer c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
HAVING COUNT(*) = 3;

SELECT * FROM customer;
SELECT * FROM orders;