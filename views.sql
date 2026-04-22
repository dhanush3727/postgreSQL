-- Views
CREATE VIEW active_users AS
SELECT * FROM test_type
WHERE is_active = true 
WITH CHECK OPTION; -- This one only allow rows insert / update that satisfy the condition defined in the view.

-- Insert / update / delete opearations
INSERT INTO active_users (name, is_active)
VALUES ('John', true);

UPDATE active_users
SET age = 30, data = '{"role" : "Manager"}'
WHERE id = 6;

DELETE FROM active_users
WHERE id =6;

UPDATE active_users
SET is_active = false
WHERE id = 7;

SELECT * FROM active_users;

-- Materialized Views
CREATE MATERIALIZED VIEW users_order_summary AS
SELECT c.id, c.name, COUNT(o.customer_id) AS total 
FROM customer c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;

DROP MATERIALIZED VIEW users_order_summary;

SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM users_order_summary;