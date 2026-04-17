CREATE TABLE test_type (
id SERIAL PRIMARY KEY,
name TEXT,
age INTEGER,
is_active BOOLEAN,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
data JSONB
);

INSERT INTO test_type (name, age, is_active, data)
VALUES ('Charu', 22, true, '{"role" : "Tester"}'),
('Dhanush', 22, true, '{"role" : "Developer"}'),
('Bharani', 20, false, '{"role" : "Executive Manager"}'),
('Hari', 21, true, '{"role" : "Devops Engineer"}'),
('Jacob', 25, false, '{"role" : "Scammer"}');

SELECT * from test_type;