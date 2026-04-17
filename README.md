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