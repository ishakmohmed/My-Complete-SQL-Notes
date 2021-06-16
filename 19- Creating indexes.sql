-- Creating indexes >>>

EXPLAIN SELECT customer_id FROM customers WHERE state = 'CA';

-- in result table, if type is ALL, MySQL is gonna make a full scan on the table (here type = ALL, rows = 1000)

CREATE INDEX idx_state ON customers (state);
EXPLAIN SELECT customer_id FROM customers WHERE state = 'CA';

-- in result table, type is now ref and rows is 112, thanks to index

-- **************************************************

-- Exercise >>>

EXPLAIN SELECT customer_id FROM customers WHERE points > 1000;
CREATE INDEX idx_points ON customers (points);
EXPLAIN SELECT customer_id FROM customers WHERE points > 1000;
-- now the type is range and number of rows is 528

-- **************************************************

-- Viewing indexes >>>

SHOW INDEXES IN customers;

ANALYZE TABLE customers;

SHOW INDEXES IN customers;
-- ANALYZE TABLE customers statement will regenerate the table returned from SHOW INDEXES IN... with more accurate values

-- **************************************************

-- Prefix indexes >>>

CREATE INDEX idx_lastname ON customers (last_name(20));
-- for string or similar data types, it is compulsory to include the number of
-- characters to uniquely identify the prefix, in this case 20

-- **************************************************

-- Full-text indexes (natural mode) >>>

CREATE FULLTEXT INDEX idx_title_body ON posts (title, body);

SELECT *, MATCH(title, body) AGAINST ('react redux')
-- by including MATCH(title, body) AGAINST ('react redux') after SELECT statement, you'll get access to relevancy score
FROM posts
WHERE MATCH(title, body) AGAINST ('react redux');

-- **************************************************

-- Full-text indexes (boolean mode) >>>

SELECT *, MATCH(title, body) AGAINST ('react redux')
FROM posts
WHERE MATCH(title, body) AGAINST ('react -redux +form' IN BOOLEAN MODE);
-- need to have "form" keyword but not "redux"
-- you can also > AGAINST ('"handling a form"' IN BOOLEAN MODE) to find exact phrase in exact order

-- **************************************************

-- Composite indexes >>>

USE sql_store;

CREATE INDEX idx_state_points ON customers (state, points);

EXPLAIN SELECT customer_id FROM customers
WHERE state = 'CA' AND points > 1000;

DROP INDEX idx_state ON customers;
DROP INDEX idx_points ON customers;

-- **************************************************

-- Order of columns in composite indexes >>>

-- not gonna write code for this, but here are the order of columns:
-- - frequently used columns
-- - high cardinality columnns
-- - take your queries into account

-- anyway, you can force MySQL to use a certain index using > USE INDEX (idx_whatever_name) after FROM clause

-- **************************************************

-- When indexes are ignored >>>

CREATE INDEX idx_points ON customers (points);
-- ^ assuming there exists an index for state, if no need to add an index for state too

-- the statement ...WHERE state = 'CA' or points > 1000 will scan all lines, so >

EXPLAIN 
	SELECT customer_id FROM customers
    WHERE state = 'CA'
    UNION
    SELECT customer_id FROM customers
    WHERE points > 1000;

-- **************************************************

-- Using indexes for sorting >>>

-- important note: read file number 20 (Mosh's PDF) to understand this section + it has other performance best practices

EXPLAIN SELECT customer_id FROM customers
ORDER BY first_name;
SHOW STATUS LIKE 'last_query_cost';

-- above code does not exactly explain indexes for sorting, but take note of the SHOW STATUS...

-- takeaway: if column you wanna sort is in index, it's cool, if no the cost of operation will be heavy

-- if you have an index (a, b), you can sort like these:
-- a
-- a, b
-- a DESC, b DESC

-- but you cannot (I mean you can but the cost of operation will be heavy):
-- a, c, b
-- b