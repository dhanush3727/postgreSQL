-- Indexing
CREATE TABLE indexed_user (
id SERIAL PRIMARY KEY,
name TEXT,
email TEXT
);

INSERT INTO indexed_user (name, email)
VALUES ('John','john@gemail.com'), 
('Sarah','sarah@gemail.com'), 
('Test','test@gemail.com'), 
('Nemo','nemo@gemail.com'), 
('Bullseye','seye@gemail.com');

-- Insert Large data
INSERT INTO indexed_user (name, email)
SELECT 
'user_' || i,
'user_' || i || '@gmail.com'
FROM generate_series(1, 50000) AS i;

-- Create index on the email column
CREATE INDEX idx_user_email ON indexed_user(email);
DROP INDEX idx_user_email;

-- Composite index (multiple conditions)
CREATE INDEX idx_user_email_name ON indexed_user(email, name);
DROP INDEX idx_user_email_name;

EXPLAIN ANALYZE
SELECT * FROM indexed_user WHERE email = 'user_4004@gemail.com';

SELECT * FROM indexed_user;