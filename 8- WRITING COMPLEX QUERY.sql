-- TITLE: SUBQUERY
-- note: we can also write subquery in the FROM clause or SELECT clause

SELECT *
FROM products
WHERE unit_price > (
	SELECT unit_price
    FROM products
    WHERE product_id = 3
)

-- **************************************************

-- EXERCISE >>>
SELECT *
FROM employees
WHERE salary > (
	SELECT AVG(salary)
    FROM employees 
)

-- **************************************************

-- TITLE: THE IN OPERATOR 
SELECT *
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
    FROM order_items
)

-- **************************************************

-- EXERCISE >>>
SELECT *
FROM clients
WHERE client_id NOT IN (
	SELECT DISTINCT client_id        
    -- DISTINCT JUST TO SIMPLIFY THE SUBQUERIES RESULTS
    FROM invoices
)

 -- **************************************************

-- TITLE: SUBQUERIES VS JOINS
-- rewriting above code using join 

SELECT *
FROM clients
LEFT JOIN invoices USING (client_id)
WHERE invoice_id IS NULL

 -- **************************************************

-- EXERCISE (USING SUBQUERY NOW): FIND CUSTOMERS WHO ORDERED LETTUCE (product_id = 3) >>>
SELECT *
FROM customers
WHERE customer_id IN (       
-- when the parantheses opens, it's like you can jump wherever you want, is that right???????
	SELECT o.customer_id
    FROM order_items oi
    JOIN orders o USING (order_id)
    WHERE product_id = 3
)

-- **************************************************

-- EXERCISE (DOING THE SAME THING USING "JOIN" NOW) >>>
SELECT DISTINCT customer_id, first_name, last_name
FROM customers 
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE oi.product_id = 3

-- **************************************************

-- TITLE: THE ALL KEYWORD 
-- without ALL >>>
SELECT *
FROM invoices
WHERE invoice_total > (
	SELECT MAX(invoice_total)
	FROM invoices
	WHERE client_id = 3
)

-- **************************************************

-- with ALL (same result) >>>
SELECT *
FROM invoices
WHERE invoice_total > ALL(            
-- in previous implementation, mysql compared each row with max value, now its comparing each row with all multiple invoice total of client with ID 3!
	SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
)

-- CONCLUSION: THESE 2 IMPLEMENTATION ARE INTERCHANGEABLE, WHEREVER YOU HAVE THE ALL KEYWORD, YOU CAN REWRITE THE QUERY USING MAX AGGREGATE FUNCTION <<< THAT'S WHAT MOSH SAID!

-- **************************************************

-- TITLE: THE ANY/SOME KEYWORD!
-- ALL YOU NEED TO KNOW: "= ANY" is equivalent to "IN"

SELECT *
FROM clients
WHERE client_id IN (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2         
    -- iirc, having needa refer to cols in SELECT, but I guess COUNT(*) is a general thing so nvm???
)

-- **************************************************

-- REWRITING ABOVE STUFF USING ANY >>>
SELECT *
FROM clients
WHERE client_id = ANY (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2        
)

-- **************************************************

-- TITLE: CORRELATED SUBQUERIES 
-- find employee that has greater avg salary in each office

SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id        
    -- if you don't get it, for each employee up there, it'll check this parantheses but only for those which has office IDs as that 1 employee in every iteration!
)

-- NOTE^^^: this is a correlated (opposite is uncollerated) subquery because the subquery has correlation with outer query (look at e alias)!
-- NOTE: correlated subquery gets executed for each row in the main query, which makes it slower sometimes!

-- **************************************************

-- EXERCISE: for each client, find average invoice_total, and return only the invoices higher than his average >>>

SELECT *
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
    FROM invoices
    WHERE i.client_id = client_id
) 

-- **************************************************

-- TITLE: THE EXISTS OPERATOR >>>

-- select clients that have an invoice
-- you already know how to do this using IN operator (for subquery), or by Inner joining the table,
-- but now we're gonna use the EXISTS operator >>>

SELECT *
FROM clients c
WHERE EXISTS (                 
	-- if you use IN operator, and it returns millions of results, its not really suitable, but EXISTS is because subquery doesn't return result to the outer query, rather it will return an indication whether any row in the subquery matches the search condition (WHERE clause in subquery), if any row meets search criteria, then the subquery returns true to the exists operator!
	SELECT client_id           
    -- not sure if right or no, but I guess just select stuffs that would be in the where clause
    FROM invoices
    WHERE client_id = c.client_id
)

-- CONCLUSION: IF SUBQUERY RETURNS A LARGE RESULT SET, THEN IT IS MORE SUITABLE TO USE THE EXISTS OPERATOR

-- **************************************************

-- EXERCISE >>>
-- if you don't understand this solution, refer all notes above for this title
SELECT *
FROM products p
WHERE NOT EXISTS (
	SELECT product_id
    FROM order_items
    WHERE product_id = p.product_id
) 

-- **************************************************

-- TITLE: SUBQUERIES IN THE SELECT CLAUSE
SELECT 
	invoice_id,
	invoice_total, 
    (SELECT AVG(invoice_total) FROM invoices) AS invoice_average,  
-- I guess you're using subquery because you want the same invoice average for all records
    invoice_total - (SELECT invoice_average) AS difference 
-- note: you cannot use column alias in expression, so either copy the entire expression or SELECT alias name
FROM invoices

-- **************************************************

-- EXERCISE >>>

-- MY OWN SOLUTION WHICH PROBABLY DIDN'T MEET THE SOLUTION CRITERIA, BUT WORKS PERFECT >>>
SELECT
	client_id,
    c.name,
    SUM(invoice_total) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices) AS average,
	SUM(invoice_total) - (SELECT AVG(invoice_total) FROM invoices) AS difference
FROM invoices 
RIGHT JOIN clients c USING (client_id)
GROUP BY client_id

-- **************************************************

-- MOSH'S SOLUTION >>>
SELECT 
	client_id, 
    name, 
    (SELECT SUM(invoice_total)
		FROM invoices
		WHERE client_id = c.client_id) AS total_sales,    
-- I guess instead of using group by, you're using correlated subquery!
    (SELECT AVG(invoice_total) FROM invoices) AS average, 
	(SELECT total_sales - average) AS difference    
-- you cannot use alias in expression, so you're using the SELECT clause (1 clause for both stuffs and wrap them in parantheses)
FROM clients c

-- **************************************************

-- TITLE: SUBQUERIES IN THE FROM clause 
-- informal: basically, im gonna place the above codes (which is my customly derived "table") in the FROM clause to use it as a table!

SELECT *
FROM (
	SELECT 
		client_id, 
		name, 
		(SELECT SUM(invoice_total)
			FROM invoices
			WHERE client_id = c.client_id) AS total_sales,  
		(SELECT AVG(invoice_total) FROM invoices) AS average, 
		(SELECT total_sales - average) AS difference  
	FROM clients c
) AS sales_summary 
-- whenever we use a subquery in a FROM clause, we need to give the subquery an alias, its a MUST!
WHERE total_sales IS NOT NULL

-- MOSH >>> "we can also take this table and join it with another table, the possibilities are endless"
-- CONCLUSION: we can use subquery in FROM clause, but just reserve it for simple queries!!!!!!!!!!!!!!