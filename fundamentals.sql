-- Data Type
CREATE TABLE test_type (
id SERIAL PRIMARY KEY,
name TEXT,
age INTEGER,
is_active BOOLEAN,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
data JSONB
);

INSERT INTO test_type (name, age, is_active, data)
VALUES ('Charu', 22, true, '{"role" : "Tester"}'),
('Dhanush', 22, true, '{"role" : "Developer"}'),
('Bharani', 20, false, '{"role" : "Executive Manager"}'),
('Hari', 21, true, '{"role" : "Devops Engineer"}'),
('Jacob', 25, false, '{"role" : "Scammer"}');

-- Primary and Foreign key
CREATE TABLE customer (
id SERIAL PRIMARY KEY,
name TEXT
);

CREATE TABLE orders (
id SERIAL PRIMARY KEY,
product TEXT,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(id) 
);

INSERT INTO customer (name)
VALUES ('Dhanush'), ('Charu');

INSERT INTO orders (product, customer_id)
VALUES ('Laptop', 2), ('PS5', 1);

INSERT INTO orders (product, customer_id)
VALUES ('Tablet', 3);

DELETE FROM customer WHERE id = 1;

-- Constraints
CREATE TABLE users (
id SERIAL PRIMARY KEY,
name TEXT NOT NULL,
email TEXT UNIQUE NOT NULL,
age INT CHECK(age >=18)
);

SELECT * FROM test_type;
SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM users;