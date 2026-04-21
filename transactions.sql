-- Transactions
BEGIN;
INSERT INTO accounts (name, balance) VALUES ('Alice', 1000);
INSERT INTO accounts (name, balance) VALUES ('Bob', 500);
COMMIT;

BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE name = 'Alice';
UPDATE accounts SET balance = balance + 100 WHERE name = 'Bob';
COMMIT;
