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