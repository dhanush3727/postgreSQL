-- Relationship
-- 1 to 1
CREATE TABLE profile (
id SERIAL PRIMARY KEY,
bio TEXT,
user_id INT UNIQUE
);

INSERT INTO users (name)
VALUES ('Dhanush');

INSERT INTO profile (bio, user_id)
VALUES ('Developer', 1);

-- 1 to many
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

INSERT INTO orders (product, customer_id)
VALUES ('Iphone', 2), ('PC', 1), ('Sony headset', 2), ('Airpods', 1);

-- many to many
CREATE TABLE teams (
id SERIAL PRIMARY KEY,
name TEXT
);

CREATE TABLE user_team (
user_id INT,
team_id INT,
FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (team_id) REFERENCES teams(id)
);

INSERT INTO teams (name)
VALUES ('Backend'), ('Frontend');

INSERT INTO user_team (user_id, team_id)
VALUES (8,2),(9,1),(9,2),(8,1);

SELECT * FROM profile;
SELECT * FROM users;
SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM teams;
SELECT * FROM user_team;