-- Query Optimization
-- Explain Analyze
CREATE INDEX idx_user ON indexed_user(name);

EXPLAIN ANALYZE
SELECT name, email FROM indexed_user 
WHERE name = 'user_4004';

EXPLAIN ANALYZE
SELECT * FROM indexed_user 
WHERE name LIKE 'user_1%';

-- Composite Index
CREATE INDEX idx_user_email ON indexed_user(name, email);

EXPLAIN ANALYZE
SELECT name, email FROM indexed_user
WHERE name LIKE '%00' AND email = 'user_5000@gmail.com';

-- Pagination
SELECT * FROM test_type
LIMIT 3;

-- Offset based pagination
SELECT * FROM test_type
LIMIT 3
OFFSET 1;

-- Cursor based pagination
-- First request
SELECT * FROM test_type
ORDER BY id ASC
LIMIT 3;

-- Next request
SELECT * FROM test_type
WHERE id > 3
ORDER BY id ASC
LIMIT 3;