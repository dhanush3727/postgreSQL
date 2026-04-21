-- Query Optimization
-- Explain Analyze
CREATE INDEX idx_user ON indexed_user(name);

EXPLAIN ANALYZE
SELECT name, email FROM indexed_user WHERE name = 'user_4004';

EXPLAIN ANALYZE
SELECT * FROM indexed_user WHERE name LIKE 'user_1%';
