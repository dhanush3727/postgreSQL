-- Query Writing
-- SELECT + WHERE
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