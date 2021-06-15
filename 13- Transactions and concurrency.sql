-- Transactions >>>

USE sql_store;

START TRANSACTION;

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 1);

COMMIT;
-- sometimes, you might wanna manually roll back the transaction, 
-- in those cases, instead of 'COMMIT', you can use 'ROLLBACK'

-- note, MySQL wraps all statements with transaction, to verify > SHOW VARIABLES LIKE 'autocommit';

-- **************************************************

-- Concurrency & locking >>>

-- Concurrency problems
-- - lost updates
-- - dirty reads
-- - non-repeating reads
-- - phantom reads

-- **************************************************

-- Transaction isolation levels >>>

SHOW VARIABLES LIKE 'transaction_isolation';
-- in MySQL default transaction isolation level is repeatable-read

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- **************************************************

-- READ UNCOMMITTED isolation level >>>

USE sql_store;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT points
FROM customers
WHERE customer_id = 1;

-- meanwhile, in another session >

USE sql_store;
START TRANSACTION;
UPDATE customers
SET points = 20
WHERE customer_id = 1;
COMMIT;

-- READ UNCOMMITTED is the lowest level, and you might face all sorts of concurrency problems

-- **************************************************

-- READ COMMITTED isolation LEVEL >>>

-- same thing like previous one, but now statements from other sessions will only read committed data

USE sql_store;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT points
FROM customers
WHERE customer_id = 1;

-- with this arises another problem: non-repeatable reads

-- **************************************************

-- REPEATABLE READ isolation level (default isolation level in MySQL) >>>

USE sql_store;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT points FROM customers WHERE customer_id = 1;
SELECT points FROM customers WHERE customer_id = 1;
COMMIT;

-- with this arises another problem: phantom reads

-- **************************************************

-- SERIALIZABLE isolation level >>>

-- basically the best one, solves all problems including phantom reads
USE sql_store;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
SELECT * FROM customers WHERE state = 'VA';
COMMIT;

-- **************************************************

-- Deadlocks >>>

-- I'll just write pseudocode for this

-- In session 1:
-- START TRANSACTION
-- update table 1
-- update table 2
-- COMMIT

-- In session 2:
-- START TRANSACTION
-- update table 2
-- update table 1
-- COMMIT

-- yeah, deadlock!