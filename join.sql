-- Join
-- Inner Join(returns matching records)
SELECT c.name, o.product FROM customer c
INNER JOIN orders o ON c.id = o.customer_id;

-- Left Join(return left side full records and right side matching records)
SELECT c.name, o.product FROM customer c
LEFT JOIN orders o ON c.id = o.customer_id;

-- Right Join(return right side full records and left side matching records)
SELECT c.name, o.product FROM customer c
RIGHT JOIN orders o ON c.id = o.customer_id;

-- Full Outer Join
SELECT c.name, o.product FROM customer c
FULL OUTER JOIN orders o ON c.id = o.customer_id;

-- Cross Join
SELECT c.name, o.product FROM customer c
CROSS JOIN orders o;

-- Natural Join
SELECT c.name, o.product FROM customer c
NATURAL JOIN orders o;

SELECT * FROM customer;
SELECT * FROM orders;