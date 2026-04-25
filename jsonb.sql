-- JSON/JSONB
-- Insert/Update Data to JSONB
INSERT INTO test_type (name, data)
VALUES ('Sarah', '{"role": ".net developer"}');

UPDATE test_type
SET data = jsonb_set(data, '{role}', '"Executive Manager"')
WHERE id = 7;

-- Get Values
SELECT data->'role' FROM test_type;
SELECT data->>'role' FROM test_type;

-- Delete a specific row
DELETE FROM test_type
WHERE id = 7;

-- Filter using JSONB
SELECT * FROM test_type
WHERE data->> 'role' = 'FullStack Developer';

-- Indexing JSONB
CREATE INDEX idx_users_data
ON test_type USING GIN (data);

SELECT * FROM test_type;