# PostgreSQL
- Database Fundamentals
- Relationships
- Indexing
- Query writing
- Query optimization
- Pagination
- Transactions
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
### Introduction to relationships:
A relationship in PostgreSQL means how tables are connected to another table using keys. Ex: In the previous example, we have two tables: `customer` and `orders`. The `customer_id` column in the `orders` table is a foreign key that references the `id` column in the `customer` table. This establishes a relationship between the two tables, allowing us to associate each order with a specific customer.

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
Many-to-many is always implemented using a third table, the table is called junction, bridge, or mapping table.
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


## Indexing
### Introduction to indexing:
Indexing is a technique used to improve the performance of database queries by allowing the database to quickly locate and retrieve data. An index is a data structure that stores a mapping of the values in a column to their corresponding row locations in the table. When a query is executed, the database can use the index to quickly find the relevant rows without having to scan the entire table.
Ex:
```sql
CREATE TABLE indexed_user (
id SERIAL PRIMARY KEY,
name TEXT,
email TEXT
);

-- Insert Large data
INSERT INTO indexed_user (name, email)
SELECT 
'user_' || i,
'user_' || i || '@gmail.com'
FROM generate_series(1, 50000) AS i;

-- Create index on the email column
CREATE INDEX idx_user_email ON indexed_user(email);

-- Query using the index
EXPLAIN ANALYZE
SELECT * FROM indexed_user WHERE email = 'user_1000@gmail.com';
```
Output:
```
Index Scan using idx_user_email on indexed_user  (cost=0.29..8.31 rows=1 width=36) (actual time=0.012..0.013 rows=1 loops=1)
  Index Cond: (email = 'user_1000@gmail.com')
Planning Time: 0.123 ms
Execution Time: 0.025 ms
```
In this example, we create a table called `indexed_user` and insert a large number of records. We then create an index on the `email` column. When we execute a query that filters by the `email` column, the database uses the index to quickly locate the relevant row, resulting in significantly improved query performance compared to a full table scan. The `EXPLAIN ANALYZE` command shows that the query uses an index scan, which is much faster than scanning the entire table.


### Indexing strategies:
- Choose the right index type based on the data and query patterns. For example, use a B-tree index for general-purpose indexing and a GIN index for full-text search.
- Index columns that are frequently used in WHERE clauses, JOIN conditions, and ORDER BY clauses to improve query performance.
- Avoid indexing columns that have low cardinality (i.e., columns with few distinct values), as they may not provide significant performance benefits and can increase storage requirements. Ex: Indexing a boolean column may not be effective if it has a high proportion of true or false values.
- Consider the trade-offs between read and write performance when creating indexes. While indexes can improve read performance, they can also slow down write operations (INSERT, UPDATE, DELETE) because the index needs to be updated whenever the data changes.
- Regularly monitor and analyze the performance of your indexes using tools like `EXPLAIN ANALYZE` to identify any indexes that are not being used effectively and consider dropping or modifying them as needed.
- Use partial indexes to index only a subset of the data when appropriate, which can reduce storage requirements and improve query performance for specific queries.
- Consider the order of columns in multicolumn indexes, as it can affect query performance. For example, if you have a multicolumn index on (column1, column2), it will be more efficient for queries that filter on column1 than for queries that filter on column2 alone.
- Regularly maintain your indexes by performing operations like `REINDEX` to rebuild indexes and `VACUUM` to clean up dead tuples, which can help improve query performance and reduce storage requirements.

## Query writing
### Query writing overview:
Query writing is the process of creating SQL statements to interact with a database. It involves using various SQL commands and clauses to retrieve, manipulate, and manage data in a PostgreSQL database. Effective query writing is essential for optimizing performance and ensuring that the database operations are efficient and accurate.

### SELECT + WHERE:
The `SELECT` statement is used to retrieve data from a database, while the `WHERE` clause is used to filter the results based on specific conditions. Ex:
```sql
-- Operators
SELECT name, age FROM test_type 
WHERE age = 22;

SELECT name FROM test_type 
WHERE age < 22;

SELECT name FROM test_type 
WHERE name = 'Charu' AND age = 22;

SELECT name FROM test_type 
WHERE name = 'Dhanush' OR name = 'Ramesh';

-- IN(Instead of OR)
SELECT name, age FROM test_type 
WHERE name IN ('Dhanush', 'Ramesh');

-- LIKE(Pattern Search)
SELECT * FROM test_type
WHERE name LIKE 'D%';

SELECT * FROM test_type
WHERE name LIKE '%i';

SELECT * FROM test_type
WHERE name LIKE '%u%';

SELECT * FROM test_type
WHERE name LIKE '_h%';

-- BETWEEN
SELECT * FROM test_type
WHERE age BETWEEN 20 AND 21;

-- NULL handling
SELECT * FROM test_type
WHERE age IS NULL;
```
In this example
- We use th comparison operators (`=`, `<`, `>`, `<=`, `>=`, `!=`) to filter results based on specific conditions.
- We use the `AND` and `OR` logical operators to combine multiple conditions in the `WHERE` clause.
- We use the `IN` operator to filter results based on a list of values, which is more efficient than using multiple `OR` conditions.
- We use the `LIKE` operator for pattern matching, allowing us to search for values that match a specific pattern. In this case, `%u%` matches any name that contains the letter 'u'. Others '%' matches any sequence of characters, and `_` matches a single character.
- We use the `BETWEEN` operator to filter results based on a range of values.
- We use `IS NULL` to filter results where a column has a null value.

### JOIN:
A `JOIN` is used to combine rows from two or more tables based on a related column between them. There are several types of joins in PostgreSQL:
- `INNER JOIN`: Returns only the rows that have matching values in both tables. Ex:
```sql
SELECT c.name, o.product FROM customer c
INNER JOIN orders o ON c.id = o.customer_id;
```
- `LEFT JOIN`: Returns all rows from the left table and the matched rows from the right table. If there is no match, the result is NULL on the right side. Ex:
```sql
SELECT c.name, o.product FROM customer c
LEFT JOIN orders o ON c.id = o.customer_id;
```
- `RIGHT JOIN`: Returns all rows from the right table and the matched rows from the left table. If there is no match, the result is NULL on the left side. Ex:
```sql
SELECT c.name, o.product FROM customer c
RIGHT JOIN orders o ON c.id = o.customer_id;
```
- `FULL OUTER JOIN`: Returns all rows when there is a match in either left or right table. If there is no match, the result is NULL on the side that does not have a match. Ex:
```sql
SELECT c.name, o.product FROM customer c
FULL OUTER JOIN orders o ON c.id = o.customer_id;
```
- `CROSS JOIN`: Returns the Cartesian product of the two tables, meaning it returns all possible combinations of rows from both tables. Ex:
```sql
SELECT c.name, o.product FROM customer c
CROSS JOIN orders o;
```
- `SELF JOIN`: A self join is a regular join but the table is joined with itself. It is used to compare rows within the same table. Ex:
```sql
SELECT a.name AS employee, b.name AS manager
FROM employees a
JOIN employees b ON a.manager_id = b.id;
```
In this example, we have an `employees` table where each employee has a `manager_id` that references the `id` of another employee. The self join allows us to retrieve the names of employees along with their managers by joining the table with itself.
- `NATURAL JOIN`: A natural join automatically joins tables based on columns with the same name and compatible data types. It eliminates the need to specify the join condition explicitly. Ex:
```sql
SELECT c.name, o.product FROM customer c
NATURAL JOIN orders o;
```
In this example, the `NATURAL JOIN` will automatically join the `customer` and `orders` tables based on the common column `customer_id`, which is present in both tables. It will return the names of customers along with their ordered products without needing to specify the join condition explicitly.
- `USING`: The `USING` clause is used in a join to specify the column(s) that should be used for the join condition when the column names are the same in both tables. It simplifies the syntax by eliminating the need to qualify the column names with table aliases. Ex:
```sql
SELECT c.name, o.product FROM customer c
JOIN orders o USING (customer_id);
```
In this example, the `USING` clause specifies that the join should be performed based on the `customer_id` column, which is present in both the `customer` and `orders` tables. This allows us to retrieve the names of customers along with their ordered products without needing to specify the join condition explicitly.

### Group By and Aggregation:
The `GROUP BY` clause is used to group rows that have the same values in specified columns into summary rows. It is often used in conjunction with aggregate functions to perform calculations on each group of data. Common aggregate functions include `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()`. Ex:
```sql
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;
HavING COUNT(*) > 1;
```
In this example, we are counting the total number of orders for each customer by grouping the results based on the `customer_id` column. The `COUNT(*)` function counts the number of rows in each group, and the result is returned as `total_orders`. The `HAVING` clause is used to filter the groups based on the aggregate function result. In this case, we are only interested in customers who have more than one order, so we use `HAVING COUNT(*) > 1` to filter the results accordingly.
Some other aggregate functions include:
- `SUM()`: Calculates the total sum of a numeric column.
- `AVG()`: Calculates the average value of a numeric column.
- `MIN()`: Finds the minimum value in a column.
- `MAX()`: Finds the maximum value in a column.
- `COUNT()`: Counts the number of rows in a group.
- `ARRAY_AGG()`: Aggregates values into an array.
- `STRING_AGG()`: Concatenates values into a single string with a specified separator.
- `JSON_AGG()`: Aggregates values into a JSON array.
- `JSONB_AGG()`: Aggregates values into a JSONB array.
- `BOOL_AND()`: Returns true if all input values are true, otherwise returns false.
- `BOOL_OR()`: Returns true if at least one input value is true, otherwise returns false.
- `VARIANCE()`: Calculates the variance of a numeric column.    
- `STDDEV()`: Calculates the standard deviation of a numeric column.

Group By + Join:
```sql
SELECT c.name, COUNT(o.id) AS total_orders
FROM customer c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;
```
In this example, we are joining the `customer` and `orders` tables to count the total number of orders for each customer. We group the results by the customer's name using the `GROUP BY` clause, and we use the `COUNT(o.id)` function to count the number of orders for each customer. The result is returned as `total_orders` alongside the customer's name.

### Order By
The `ORDER BY` clause is used to sort the result set of a query based on one or more columns. By default, the sorting is done in ascending order, but you can specify descending order using the `DESC` keyword. Ex:
```sql
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
```
In this example, we demonstrate the use of the `ORDER BY` clause in different contexts. The first query sorts the `orders` table by the `product` column in ascending order. The second query sorts the `orders` table first by `customer_id` in ascending order and then by `product` in descending order. The third query joins the `customer` and `orders` tables and sorts the results by the customer's name in ascending order. The fourth query groups the orders by `customer_id`, counts the total number of orders for each customer, and sorts the results by `customer_id` in ascending order.

### Limit and Offset
The `LIMIT` clause is used to specify the maximum number of rows to return in the result set, while the `OFFSET` clause is used to specify the number of rows to skip before starting to return rows. These clauses are often used together for pagination purposes. Ex:
```sql
SELECT * FROM orders
ORDER BY id ASC
LIMIT 10 OFFSET 20;
```
In this example, we are retrieving rows from the `orders` table, sorting them by the `id` column in ascending order. The `LIMIT 10` clause specifies that we want to return a maximum of 10 rows, while the `OFFSET 20` clause indicates that we want to skip the first 20 rows before starting to return results. This is useful for implementing pagination, allowing us to retrieve a specific subset of results from a larger dataset.


## Query optimization
### Overview of query optimization:
Query optimization is the process of improving the performance of database queries by analyzing and modifying the query execution plan. PostgreSQL uses a query planner to determine the most efficient way to execute a query based on factors such as available indexes, data distribution, and statistics. By optimizing queries, you can reduce execution time and improve overall database performance.

### Explain and Explain Analyze:
The `EXPLAIN` command is used to display the execution plan of a query without actually executing it. It provides information about how PostgreSQL plans to execute the query, including the order of operations, the use of indexes, and the estimated cost of each step. The `EXPLAIN ANALYZE` command executes the query and provides detailed information about the actual execution time and the number of rows processed at each step. Ex:
```sql
EXPLAIN SELECT * FROM orders WHERE product = 'Laptop';

EXPLAIN ANALYZE SELECT * FROM orders WHERE product = 'Laptop';
```
In this example, the first command `EXPLAIN` will show the execution plan for the query that retrieves orders where the product is 'Laptop'. It will provide information about how PostgreSQL plans to execute the query, such as whether it will use an index or perform a sequential scan. The second command `EXPLAIN ANALYZE` will execute the same query and provide detailed information about the actual execution time and the number of rows processed at each step of the execution plan. This allows you to analyze the performance of the query and identify any potential bottlenecks or areas for optimization.

- Index usage:
To optimize query performance, it is important to ensure that the appropriate indexes are being used. You can check if an index is being used by looking at the execution plan provided by `EXPLAIN` or `EXPLAIN ANALYZE`. If an index is not being used when it should be, you may need to create an index on the relevant column(s) or modify your query to take advantage of existing indexes. Ex:
```sql
CREATE INDEX idx_orders_product ON orders(product);
EXPLAIN ANALYZE SELECT * FROM orders WHERE product = 'Laptop';
```
In this example, we create an index on the `product` column of the `orders` table. After creating the index, we use `EXPLAIN ANALYZE` to execute the query that retrieves orders where the product is 'Laptop'. By analyzing the execution plan, we can confirm that the index is being used, which should result in improved query performance compared to a sequential scan of the entire table.

- Sequential scan vs index scan:
A sequential scan is when PostgreSQL reads through the entire table to find the relevant rows for a query. This can be inefficient for large tables, especially if there are indexes available that could be used to quickly locate the relevant rows. An index scan, on the other hand, allows PostgreSQL to use an index to quickly find the relevant rows without having to read through the entire table. To optimize query performance, it is generally recommended to use indexes whenever possible, as they can significantly reduce the execution time of queries by avoiding full table scans. Ex:
```sql
EXPLAIN ANALYZE SELECT * FROM orders WHERE product = 'Laptop';
```
In this example, if there is no index on the `product` column, PostgreSQL will perform a sequential scan of the `orders` table to find rows where the product is 'Laptop'. This can be inefficient, especially if the table is large. However, if we create an index on the `product` column (as shown in the previous example), PostgreSQL will use an index scan to quickly locate the relevant rows, resulting in improved query performance. By analyzing the execution plan with `EXPLAIN ANALYZE`, we can confirm whether a sequential scan or an index scan is being used for the query.

- Final workflow:
1. Write query
2. Run EXPLAIN ANALYZE
3. See:
   - Seq Scan?
   - High rows removed?
4. Add index (only if needed)
5. Re-check with EXPLAIN ANALYZE
6. Repeat until satisfied with performance

### Avoid SELECT *:
`SELECT *` this fetches all columns from the table. At small scale you won't notice anything but at real scale this becomes a performance problem. Always select only the columns you need. Ex:
```sql
SELECT name, age FROM test_type WHERE age > 20;
```
In this example, instead of using `SELECT *`, we specify the columns we need (`name` and `age`) in the SELECT statement. This allows PostgreSQL to only retrieve the necessary data, which can improve query performance, especially if the table has many columns or if there are large amounts of data. By avoiding `SELECT *`, we reduce the amount of data that needs to be processed and transferred, leading to faster query execution and improved overall performance.

- What actually happens when you run `SELECT *`:
1. Reads every column
2. Loads it into memory
3. Sends all data over network
4. Your backend process it
5. Your frontend receives it

### Use Index properly:
1. When to use index:
  - Exact match queries (e.g., `WHERE column = value`)
  - Range queries (e.g., `WHERE column > value`)
  - Sorting (e.g., `ORDER BY column`)
  - Join conditions (e.g., `JOIN ON column`)

2. When not to use index:
  - When the column has low cardinality (few distinct values)
  - When the table is small (sequential scan may be faster)
  - When the query does not filter on the indexed column
  - When the query retrieves a large portion of the table (e.g., `SELECT *` without a `WHERE` clause)
  - When the query is not performance-critical and the overhead of maintaining the index outweighs the benefits
  - When the query is write-heavy (e.g., many INSERTs, UPDATEs, DELETEs) and the index would slow down write performance
  - When the query is not using the indexed column in a way that can take advantage of the index (e.g., using functions on the indexed column without a functional index)

3. Types of indexes:
  - Single-column index: An index on a single column. Ex: `CREATE INDEX idx_column ON table(column);`
  - Composite index: An index on multiple columns. Ex: `CREATE INDEX idx_columns ON table(column1, column2);`
  - Unique index: An index that enforces uniqueness of the indexed column(s). Ex: `CREATE UNIQUE INDEX idx_unique ON table(column);`
  - Partial index: An index that only includes rows that satisfy a specified condition. Ex: `CREATE INDEX idx_partial ON table(column) WHERE condition;`
  - Expression index: An index based on an expression rather than a column. Ex: `CREATE INDEX idx_expression ON table((column1 + column2));`

4. Composite index:
A composite index is an index that includes multiple columns. It can be used to optimize queries that filter on multiple columns. However, the order of the columns in the composite index matters. The index can only be used efficiently if the query filters on the leading column(s) of the index. Ex:
```sql
CREATE INDEX idx_composite ON orders(customer_id, product);
```
In this example, we create a composite index on the `customer_id` and `product` columns of the `orders` table. This index can be used to optimize queries that filter on both `customer_id` and `product`, or just on `customer_id`. However, if a query only filters on `product` without filtering on `customer_id`, the composite index may not be used efficiently, and a sequential scan may occur instead. Therefore, it is important to consider the query patterns when creating composite indexes to ensure they are effective in improving query performance.

### Reducing Joins:
Joins can be expensive in terms of performance, especially when dealing with large datasets. To reduce the number of joins in a query, you can consider the following strategies:
1. Denormalization: This involves duplicating data across tables to avoid the need for joins. While this can improve read performance, it can also lead to data redundancy and potential inconsistencies, so it should be used with caution.
2. Subqueries: Instead of joining tables, you can use subqueries to retrieve the necessary data. This can sometimes be more efficient than a join, especially if the subquery can be optimized separately.
3. Materialized views: If you have complex queries that involve multiple joins and are frequently executed, you can create a materialized view that precomputes the results of the query. This can significantly improve performance, as the results are stored and can be quickly retrieved without needing to perform the joins each time.
4. Caching: If the results of a query are not changing frequently, you can cache the results in your application layer to avoid hitting the database for every request. This can reduce the load on the database and improve response times.
5. Indexing: Ensure that the columns used in join conditions are properly indexed to improve the performance of the join operations. This can help reduce the time taken to execute joins and improve overall query performance.

## Pagination
### Overview of pagination:
Pagination is the process of dividing a large result set into smaller, more manageable chunks or pages. This is often done to improve performance and user experience when dealing with large datasets. In PostgreSQL, you can implement pagination using the `LIMIT` and `OFFSET` clauses in your SQL queries. Ex:
```sql
SELECT * FROM orders
LIMIT 10;
```
In this example, we are retrieving the first 10 rows from the `orders` table. This is useful for displaying a limited number of results on a page, such as in a web application.

### Offset-based pagination:
Offset-based pagination uses the `OFFSET` clause to specify the number of rows to skip before starting to return rows. This allows you to retrieve a specific page of results. Ex:
```sql
SELECT * FROM orders
LIMIT 10 OFFSET 20;
```
In this example, we are retrieving rows from the `orders` table, sorting them by the `id` column in ascending order. The `LIMIT 10` clause specifies that we want to return a maximum of 10 rows, while the `OFFSET 20` clause indicates that we want to skip the first 20 rows before starting to return results.
But offset-based pagination can become problems when
- The dataset is large, Ex: `OFFSET 1000000` wil be very slow because it has to skip a large number of rows before returning the desired results.
- When there are frequent inserts or deletes in the table, which can cause the offset to return inconsistent results as the underlying data changes between queries.

### Cursor-based pagination:
Cursor-based pagination uses a cursor to keep track of the last retrieved row and allows you to fetch the next set of results based on that cursor. This can be more efficient than offset-based pagination, especially for large datasets, as it avoids the need to skip a large number of rows. Ex:
```sql
-- First request
SELECT * FROM orders
ORDER BY id ASC
LIMIT 10;

-- Subsequent request using the last retrieved id as the cursor
SELECT * FROM orders
WHERE id > last_retrieved_id
ORDER BY id ASC
LIMIT 10;
```
In this example, the first query retrieves the first 10 rows from the `orders` table, ordered by the `id` column in ascending order. The second query retrieves the next set of results by using the last retrieved `id` as a cursor.

## Transactions
### Overview of transactions:
A transaction is a group of SQL operations treated as one unit of work. Either all operations succeed or none of them happen. Transactions ensure data integrity and consistency in a database. In PostgreSQL, you can use the `BEGIN`, `COMMIT`, and `ROLLBACK` commands to manage transactions. Ex:
```sql
BEGIN;

-- This query insert a new customer and returning the id of that customer to create a new order for that customer.
-- WITH clause is used to create a temporary result set that can be referenced within the main query.
WITH new_customer AS (
  INSERT INTO customer (name)
  VALUES ('KaraSaami')
  RETURNING id
)
INSERT INTO orders (customer_id)
SELECT id FROM new_customer;

-- when run the above query if it is run wihtout error then run the commit
COMMIT; 

-- If anything wrong or we want revert that then use rollback
ROLLBACK;
```
In this example
- We start a stransaction with the `BEGIN` command.
- We use a `WITH` clause to insert a new customer into the `customer` table and return the `id` of the newly inserted customer. This allows us to create a new order for that customer in the same transaction.
- If the transaction executes successfully without any errors, we use the `COMMIT` command to save the changes to the database.
- If there is an error or if we want to revert the changes made in the transaction, we can use the `ROLLBACK` command to undo all operations performed in the transaction, ensuring that the database remains in a consistent state.

1. ACID Properties of Transactions:
ACID is an acronym that stands for Atomicity, Consistency, Isolation, and Durability. These properties ensure that transactions are processed reliably in a database system.
- Atomicity: In transaction one query fails, everything failed. Ex: While tranfering money both debit and credit must succeed, if one fails nothing should change.
- Consistency: Database moves from one valid state to another valid state. Ex: Balance should never be negative.
- Isolation: Transactions should not interfere with each other. Ex: Two transactions trying to update the same record should not cause data corruption.
- Durability: Once committed, data is safe even after crash. Ex: After money transfer, the changes should persist even if there is a power failure.

### Locking and concurrency control:
Locking is a mechanism used to control concurrent access to database resources. PostgreSQL uses various types of locks to ensure data integrity and consistency when multiple transactions are accessing the same data simultaneously. Ex:
```sql
BEGIN;
SELECT * FROM orders
WHERE id = 1
FOR UPDATE;
```
In this example,
- We start a transaction with the `BEGIN` command.
- We execute a `SELECT` statement to retrieve the order with `id = 1` and use the `FOR UPDATE` clause to acquire a lock on that row. This means that other transactions will not be able to modify or delete this row until the current transaction is completed (either committed or rolled back). This helps to prevent data corruption and ensures that concurrent transactions do not interfere with each other when accessing the same data.

1. Types of Locks:
- Row-level locks: Locks a specific row in a table. Ex: `SELECT * FROM orders WHERE id = 1 FOR UPDATE;`
- Table-level locks: locks an entire table. Ex: `LOCK TABLE orders IN EXCLUSIVE MODE;`
- Advisory locks: Application-defined locks that can be used for custom concurrency control. Ex: `SELECT pg_advisory_lock(12345);`

2. Deadlocks:
A deadlock occurs when two or more transactions are waiting for each other to release locks, resulting in a situation where none of the transactions can proceed. PostgreSQL detects deadlocks and automatically resolves them by aborting one of the transactions involved in the deadlock. To avoid deadlocks, it is important to ensure that transactions acquire locks in a consistent order and to keep transactions as short as possible to minimize the time locks are held. Ex:
```sql
-- Transaction 1
BEGIN;

SELECT * FROM orders WHERE id = 1 FOR UPDATE;

-- Transaction 2
BEGIN;

SELECT * FROM orders WHERE id = 2 FOR UPDATE;

-- Transaction 1 tries to acquire a lock on order id 2
SELECT * FROM orders WHERE id = 2 FOR UPDATE;

-- Transaction 2 tries to acquire a lock on order id 1
SELECT * FROM orders WHERE id = 1 FOR UPDATE;
```
In this example,
- Transaction 1 starts and acquires a lock on the order with `id = 1`.
- Transaction 2 starts and acquires a lock on the order with `id = 2`.
- Transaction 1 then tries to acquire a lock on the order with `id = 2`, but it is already locked by Transaction 2, so Transaction 1 is now waiting for Transaction 2 to release the lock.
- Transaction 2 then tries to acquire a lock on the order with `id = 1`, but it is already locked by Transaction 1, so Transaction 2 is now waiting for Transaction 1 to release the lock.
This creates a deadlock situation where both transactions are waiting for each other to release locks, and neither transaction can proceed. PostgreSQL will detect this deadlock and automatically resolve it by aborting one of the transactions, allowing the other transaction to proceed. To avoid such situations, it is important to ensure that transactions acquire locks in a consistent order and to keep transactions as short as possible to minimize the time locks are held.

### Isolation levels:
Isolation levels determine how transactions interact with each other and how they see changes made by other transactions. PostgreSQL supports the following isolation levels:
- Read Uncommitted: Allows transactions to see uncommitted changes made by other transactions. This can lead to dirty reads, non-repeatable reads, and phantom reads. Ex:
```sql
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```
- Read Committed: Allows transactions to see only committed changes made by other transactions. This prevents dirty reads but can still allow non-repeatable reads and phantom reads. Ex:
```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```
- Repeatable Read: Ensures that if a transaction reads a row, it will see the same data for that row throughout the transaction, even if other transactions modify it. This prevents dirty reads and non-repeatable reads but can still allow phantom reads. Ex:
```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```
- Serializable: Provides the highest level of isolation, ensuring that transactions are executed in a way that they appear to be executed serially, even if they are executed concurrently. This prevents dirty reads, non-repeatable reads, and phantom reads. Ex:
```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```
In this example, we can set the isolation level for a transaction using the `SET TRANSACTION ISOLATION LEVEL` command. Each isolation level provides different guarantees about how transactions interact with each other and what data they can see. Choosing the appropriate isolation level depends on the specific requirements of your application and the trade-offs between performance and data consistency that you are willing to make.

### Savepoints:
Savepoints allow you to set a point within a transaction that you can roll back to without affecting the entire transaction. This is useful for handling errors or for implementing complex transaction logic. Ex:
```sql
BEGIN;
SAVEPOINT savepoint1;
-- Some operations
SAVEPOINT savepoint2;
-- Some more operations
ROLLBACK TO savepoint1; -- This will undo the operations after savepoint1 but keep the operations before savepoint1
COMMIT; -- This will commit the remaining operations
```
In this example
- We start a transaction with the `BEGIN` command.
- We create a savepoint named `savepoint1` using the `SAVEPOINT` command. This allows us to mark a point in the transaction that we can roll back to if needed.
- We perform some operations after `savepoint1`.
- We create another savepoint named `savepoint2` to mark another point in the transaction.
- If we encounter an error or want to undo the operations performed after `savepoint1`, we can use the `ROLLBACK TO savepoint1` command. This will undo all operations performed after `savepoint1` but will keep the operations performed before `savepoint1` intact.
- Finally, we can use the `COMMIT` command to commit the remaining operations in the transaction. This allows us to have more control over the transaction and handle errors more gracefully without having to roll back the entire transaction.

## Advanced Concepts
### Views:
1. Normal view:
A view is a virtual table that is based on the result of a SQL query. It allows you to encapsulate complex queries and present them as a simple table. Views can be used to simplify query writing, improve security by restricting access to specific columns or rows, and provide a level of abstraction over the underlying data. Ex:
```sql
CREATE VIEW active_users AS
SELECT * FROM test_type
WHERE is_active = true;
WITH CHECK OPTION;
```
In this example, 
- We create a view named `active_users` that selects all columns from the `test_type` table where the `is_active` column is true. This view will only show active users.
- The `WITH CHECK OPTION` clause ensures that any insert or update operations performed on the view will only allow rows that satisfy the condition defined in the view.

2. Materialized view:
A materialized view is a view that stores the result of the query physically on disk. It can be refreshed periodically to keep the data up to date. Materialized views can improve performance for complex queries that are expensive to compute, as they allow you to retrieve precomputed results instead of executing the underlying query each time. Ex:
```sql
CREATE MATERIALIZED VIEW users_order_summary AS
SELECT c.id, c.name, COUNT(o.customer_id) AS total 
FROM customer c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;
```
In this example
- We create a materialized view named `users_order_summary` that summarizes the total number of orders for each customer. The view joins the `customer` and `orders` tables, groups the results by customer ID, and counts the number of orders for each customer.
- The result of this query is stored physically on disk, and you can refresh the materialized view periodically to keep the data up to date. This can significantly improve performance when querying the summary data, as it avoids the need to execute the complex join and aggregation query each time you want to retrieve the order summary for customers.

### Stored Procedures and Functions:
1. Stored Procedures:
A stored procedure is a set of SQL statements that can be executed on the database server. It can accept parameters, perform complex operations, and return results. Stored procedures are useful for encapsulating business logic, improving performance by reducing network round trips, and enhancing security by controlling access to the underlying data. Ex:
```sql
-- Stored Procedure
CREATE PROCEDURE create_order(id INT, item TEXT)
LANGUAGE plpgsql -- This is the procedural language for PostgreSQL
AS $$ -- Delimiter for the procedure body
BEGIN
	INSERT INTO orders(customer_id, product)
	VALUES (id, item);
END;
$$;

CALL create_order(2, 'HandBag');
SELECT * FROM orders;
```
In this example,
- We create a stored procedure named `create_order` that takes two parameters: `id` (an integer representing the customer ID) and `item` (a text representing the product name).
- The procedure is defined using the `plpgsql` language, which is a procedural language for PostgreSQL.
- The body of the procedure contains an `INSERT` statement that adds a new order to the `orders` table using the provided parameters.
- We then call the stored procedure with specific values (customer ID 2 and product 'HandBag') to create a new order, and we can query the `orders` table to see the newly inserted order. 

2. Functions:
A function is similar to a stored procedure but is designed to return a value. Functions can be used in SQL queries, allowing you to perform calculations or transformations on data directly within the query. Ex:
```sql
CREATE FUNCTION get_orders_by_user(u_id INT)
RETURNS INT -- specify data type
LANGUAGE plpgsql
AS $$
DECLARE total INT; -- variable declaration
BEGIN 
	SELECT COUNT(*) INTO total FROM orders
	WHERE customer_id = u_id;

	RETURN total;
END;
$$;

SELECT get_orders_by_user(2);
```
In this example,
- We create a function named `get_orders_by_user` that takes a single parameter `u_id` (an integer representing the user ID) and returns an integer value.
- The function is defined using the `plpgsql` language, and it declares a variable `total` to store the count of orders for the specified user.
- The function executes a `SELECT` statement to count the number of orders for the given user ID and stores the result in the `total` variable.
- Finally, the function returns the total count of orders for the specified user ID. We can call the function with a specific user ID (e.g., 2) to retrieve the total number of orders for that user.
