# PostgreSQL
- Database Fundamentals
- Relationships
- Indexing
- Query writing
- Query optimization
- Pagination
- Transactions
- Constraints & Data Integrity
- Advanced Concepts
- Scaling PostgreSQL

## Database Fundamentals
### Introduction to PostgreSQL:
PostgreSQL is an open-source relational database management system (RDBMS) that emphasizes extensibility and SQL compliance. It is widely used for its robustness, scalability, and support for advanced data types.

### Installation and Setup:
To install PostgreSQL, you can follow the instructions for your operating system on the official PostgreSQL website. After installation, you can use the `psql` command-line tool to interact with your PostgreSQL database.

### Database Creation and Management:
To create a new database, you can use the following command in the `psql` terminal:
```sql
CREATE DATABASE my_database;
```
To list all databases, use:
```sql
\l
```
To connect to a database, use:
```sql
\c my_database
```

### Data Types:
PostgreSQL supports a wide range of data types, including:
- Numeric types: `INTEGER`, `SERIAL`, `BIGINT`, `DECIMAL`, `NUMERIC`, `REAL`, `DOUBLE PRECISION`
- Character types: `CHAR`, `VARCHAR`, `TEXT`
- Date and time types: `DATE`, `TIME`, `TIMESTAMP`, `INTERVAL`
- Boolean type: `BOOLEAN`
- Array types: `INTEGER[]`, `TEXT[]`, etc.
- JSON types: `JSON`, `JSONB`
- UUID type: `UUID`
- Serial types: `SERIAL`, `BIGSERIAL`

### Example table creation:
```sql
CREATE TABLE test_type (
id SERIAL PRIMARY KEY,
name TEXT,
age INTEGER,
is_active BOOLEAN,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
data JSONB

INSERT INTO test_type (name, age, is_active, data)
VALUES ('Dhanush', 22, true, '{"role" : "Developer"}');
);
```
In this example, we create a table named `test_type` with various data types.
- id: A serial primary key that auto-increments.
- name: A text field to store names.
- age: An integer field to store ages.
- is_active: A boolean field to indicate if the record is active.
- created_at: A timestamp field that defaults to the current timestamp when a new record is inserted.
- data: A JSONB field to store JSON data. JSONB is a binary format for JSON data that allows for efficient storage and querying.

### Tables, columns, and rows:
- A table is a collection of related data organized in rows and columns. Each table has a unique name and consists of multiple columns, each with a specific data type. Ex: In our previous table creation example, `test_type` is the table.
- A column is a vertical entity in a table that contains all information associated with a specific field. Each column has a name and a data type. Ex: In our previous table creation example, `name`, `age`, `is_active`, `created_at`, and `data` are columns.
- A row is a horizontal entity in a table that contains a single record of data. Each row consists of values for each column in the table. Ex: In our previous table creation example, the inserted record with name 'Dhanush', age 22, is_active true, created_at as current timestamp, and data as '{"role" : "Developer"}' is a row in the `test_type` table.

### Primary keys and foreign keys:
- A primary key is a column or a set of columns that uniquely identifies each row in a table. It must contain unique values and cannot be null. Ex: In our previous table creation example, `id` is the primary key for the `test_type` table.
- A foreign key is a column or a set of columns in one table that refers to the primary key in another table. It establishes a relationship between the two tables.
Ex:
```sql
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
```
In this example, we have two tables: `customer` and `orders`. The `customer_id` column in the `orders` table is a foreign key that references the `id` column in the `customer` table. This establishes a relationship between the two tables, allowing us to associate each order with a specific customer.

### Constraints:
Constraints are rules that are applied to columns in a table to enforce data integrity. Common constraints include:
- `NOT NULL`: Ensures that a column cannot have a null value. Ex: `name TEXT NOT NULL`.
- `UNIQUE`: Ensures that all values in a column are unique. Ex: `email TEXT UNIQUE`.
- `PRIMARY KEY`: A combination of `NOT NULL` and `UNIQUE`. Ex: `id SERIAL PRIMARY KEY`.
- `FOREIGN KEY`: Ensures that a value in one table matches a value in another table. Ex: `customer_id INT, FOREIGN KEY (customer_id) REFERENCES customer(id)`.
- `CHECK`: Ensures that all values in a column satisfy a specific condition. Ex: `age INT CHECK (age >= 18)`.
- `DEFAULT`: Provides a default value for a column when no value is specified. Ex: `created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP`.
- `EXCLUDE`: Ensures that if any two rows are compared on the specified columns or expressions using the specified operators, at least one of these comparisons will return false or null. Ex: `EXCLUDE USING gist (box WITH &&)`.

### Basic SQL commands:
- `SELECT`: Retrieves data from a database. Ex: `SELECT * FROM test_type;`
- `INSERT`: Adds new data to a database. Ex: `INSERT INTO test_type (name, age) VALUES ('Alice', 30);`
- `UPDATE`: Modifies existing data in a database. Ex: `UPDATE test_type SET age = 31 WHERE name = 'Alice';`
- `DELETE`: Removes data from a database. Ex: `DELETE FROM test_type WHERE name = 'Alice';`
- `CREATE`: Creates a new database or table. Ex: `CREATE TABLE new_table (id SERIAL PRIMARY KEY, name TEXT);`
- `ALTER`: Modifies an existing database or table. Ex: `ALTER TABLE test_type ADD COLUMN email TEXT;`
- `DROP`: Deletes a database or table. Ex: `DROP TABLE new_table;` 
- `TRUNCATE`: Removes all rows from a table without logging individual row deletions. Ex: `TRUNCATE TABLE test_type;`
- `GRANT`: Gives specific privileges to users. Ex: `GRANT SELECT ON test_type TO user_name;`
- `REVOKE`: Removes specific privileges from users. Ex: `REVOKE SELECT ON test_type FROM user_name;`
- `COMMIT`: Saves all changes made in the current transaction. Ex: `COMMIT;`
- `ROLLBACK`: Undoes all changes made in the current transaction. Ex: `ROLLBACK;`
- `SAVEPOINT`: Sets a savepoint within a transaction to which you can later roll back. Ex: `SAVEPOINT savepoint_name;`
- `EXPLAIN`: Provides information about how PostgreSQL executes a query. Ex: `EXPLAIN SELECT * FROM test_type;`
- `EXPLAIN ANALYZE`: Executes a query and provides detailed information about the execution plan and performance. Ex: `EXPLAIN ANALYZE SELECT * FROM test_type;`.

### Schema and namespaces:
A schema is a logical container for database objects such as tables, views, and functions. It helps to organize and manage database objects. A namespace is a collection of schemas that allows you to group related schemas together. In PostgreSQL, the default schema is called `public`. You can create additional schemas to further organize your database objects.
Ex:
```sql
CREATE SCHEMA sales;
CREATE TABLE sales.orders (
id SERIAL PRIMARY KEY,
product TEXT,
quantity INT
);
```
In this example, we create a new schema called `sales` and a table called `orders` within that schema. To access the `orders` table, you would need to specify the schema name as well, like this: `SELECT * FROM sales.orders;`.

## Relationship
A relationship in postgreSQL means how tables in connected to another table using keys. Ex: In the previous example, we have two tables: `customer` and `orders`. The `customer_id` column in the `orders` table is a foreign key that references the `id` column in the `customer` table. This establishes a relationship between the two tables, allowing us to associate each order with a specific customer.

### Types of relationships:
- One-to-one: One record in table A is associated with one record in table B. Ex: A `user` table and a `profile` table where each user has one profile.
- One-to-many: One record in table A is associated with multiple records in table B. Ex: A `customer` table and an `orders` table where each customer can have multiple orders.
- Many-to-many: Multiple records in table A are associated with multiple records in table B. Ex: A `students` table and a `courses` table where each student can enroll in multiple courses and each course can have multiple students.

### one-to-one relationship:
```sql
CREATE TABLE users (
id SERIAL PRIMARY KEY,
username TEXT UNIQUE,
email TEXT UNIQUE
);

CREATE TABLE profiles (
id SERIAL PRIMARY KEY,
user_id INT UNIQUE,
bio TEXT,
FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (username, email)
VALUES ('Dhanush', 'dhanu@example.com');

INSERT INTO profiles (bio, user_id)
VALUES ('Developer', 1);
```
Output:
```
id | username | email
---+----------+-------------------
1  | Dhanush  | dhanu@example.com
2  | Charu    | charu@example.com

id | user_id | bio
---+---------+-----
1  | 1       | Developer
2  | 2       | Designer

```
In this example, we have a one-to-one relationship between the `users` table and the `profiles` table. Each user has one profile, and each profile is associated with one user through the `user_id` foreign key.

### one-to-many relationship:
```sql
CREATE TABLE customers (
id SERIAL PRIMARY KEY,
name TEXT
);

CREATE TABLE orders (
id SERIAL PRIMARY KEY,
product TEXT,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (name)
VALUES ('Dhanush'), ('Charu');

INSERT INTO orders (product, customer_id)
VALUES ('Laptop', 2), ('PS5', 1), ('Smartphone', 2), ('Tablet', 1), ('Headphones', 2);
```
Output:
```
id | name
---+------
1  | Dhanush
2  | Charu

id | product | customer_id
---+---------+-------------
1  | Laptop  | 2
2  | PS5     | 1
3  | Smartphone | 2
4  | Tablet   | 1
5  | Headphones | 2
```
In this example, we have a one-to-many relationship between the `customers` table and the `orders` table. Each customer can have multiple orders, and each order is associated with one customer through the `customer_id` foreign key.

### many-to-many relationship:
Many-to-many is always implemented using a third table called, the table is called junction, bridge, or mapping table.
```sql
CREATE TABLE students (
id SERIAL PRIMARY KEY,
name TEXT
);

CREATE TABLE courses (
id SERIAL PRIMARY KEY,
title TEXT
);

CREATE TABLE enrollments (
student_id INT,
course_id INT,
FOREIGN KEY (student_id) REFERENCES students(id),
FOREIGN KEY (course_id) REFERENCES courses(id),
);

INSERT INTO students (name)
VALUES ('Dhanush'), ('Charu');

INSERT INTO courses (title)
VALUES ('Mathematics'), ('Computer Science');

INSERT INTO enrollments (student_id, course_id)
VALUES (1, 1), (1, 2), (2, 1);
```
Output:
```
id | name
---+------
1  | Dhanush
2  | Charu

id | title
---+-------------------
1  | Mathematics
2  | Computer Science

student_id | course_id
-----------+----------
1          | 1
1          | 2 
2          | 1
``` 
In this example, we have a many-to-many relationship between the `students` table and the `courses` table. Each student can enroll in multiple courses, and each course can have multiple students. The `enrollments` table serves as a junction table that connects the two tables through foreign keys.
