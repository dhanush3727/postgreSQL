-- Transactions
BEGIN;

WITH new_customer AS (
  INSERT INTO customer (name)
  VALUES ('KaraSaami')
  RETURNING id
)
INSERT INTO orders (customer_id)
SELECT id FROM new_customer;

-- Locks
BEGIN;

SELECT product FROM orders
WHERE id = 1 FOR UPDATE;

UPDATE orders 
SET product = 'Laptops'
WHERE id = 1;

-- when run the above query if it is run wihtout error then run the commit
COMMIT; 

-- If anything wrong or we want revert that then use rollback
ROLLBACK;

SELECT * FROM orders;
SELECT * FROM customer;


