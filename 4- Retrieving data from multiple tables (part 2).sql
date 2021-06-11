-- IMPLICIT JOIN SYNTAX (MOSH DOESN'T RECOMMEND THIS cause if you forget WHERE clause, you'll get cross join) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- instead of SELECT, FROM and then JOIN, you're involving the WHERE clause

-- SELECT *
-- FROM orders o, customers c
-- WHERE o.customer_id = c.customer_id

-- so it's BETTER TO USE THE EXPLICIT JOIN SYNTAX, cause in implicit if you forget the ON clause after JOIN, you'll get syntax error



-- OUTER JOIN >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id
-- FROM customers c
-- LEFT JOIN orders o -- << this is the fix, means all the records in left table (customers) gets returned regardless if customer has order id or not
-- 	ON c.customer_id = o.customer_id  -- << problem that outer join fixed, like in this case you can't see customers who dont have any order
-- ORDER BY c.customer_id

-- NOTE: BY THE WAY BETWEEN LEFT AND JOIN, YOU CAN WRITE OUTER BUT ITS OPTIONAL, JUST LIKE THE INNER KEYWORD



-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id
-- FROM customers c
-- RIGHT OUTER JOIN orders o -- (outer is optional btw), now things work the opposite, but if you want it to work like in above code, then swap the order of the tables
-- 	ON c.customer_id = o.customer_id  
-- ORDER BY c.customer_id
-- -- CONCLUSION, IF YOU USE JOIN KEYWORD, YOU'RE DOING INNER JOIN, IF LEFT OR RIGHT JOIN, THEN OUTER. INNER AND OUTER IS OPTIONAL BTW.



-- EXERCISE
-- SELECT
-- 	p.product_id, 
-- 	p.name, 
--     o.quantity
-- FROM products p 
-- LEFT JOIN order_items o
-- 	ON p.product_id = o.product_id
-- order by p.product_id


-- NOTE: AS THE BEST PRACTICE, USE LEFT JOINS ONLY. MULTIPLE OUTER JOIN >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id,
--     sh.name AS shipper
-- FROM customers c
-- LEFT JOIN orders o
-- 	ON c.customer_id = o.customer_id
-- LEFT JOIN shippers sh
-- 	ON o.shipper_id = sh.shipper_id
-- ORDER BY c.customer_id



-- NOTE: VERY IMPORTANT >>> FROM A TABLE, YOU JOIN ANOTHER, AND THEN FROM THE SAME TABLE YOU JOIN ANOTHER, ITS LIKE A STAR TOPOLOGY.
-- SELECT 
-- 	o.order_date,
--     o.order_id,
--     c.first_name,
--     sh.name AS shipper,
--     os.name AS status
-- FROM orders o
-- JOIN customers c
-- 	ON o.customer_id = c.customer_id
-- LEFT JOIN shippers sh
-- 	ON o.shipper_id = sh.shipper_id
-- JOIN order_statuses os
-- 	ON o.status = os.order_status_id



-- SELF OUTER JOINS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- USE sql_hr;

-- SELECT 
-- 	e.employee_id,
--     e.first_name,
--     f.first_name AS manager
-- FROM employees e
-- LEFT JOIN employees f -- LEFT JOIN HERE, MEANS YOU WANT ALL RECORDS FROM employees e eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee!!!!!!!!!
-- 	ON e.reports_to = f.employee_id



-- THE USING CLAUSE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- SELECT
-- 	o.order_id,
--     c.first_name,
--     sh.name AS shipper
-- FROM orders o
-- JOIN customers c
-- 	USING (customer_id) -- the USING keyword (with parantheses()), because column name is same across both tables, a shortcut!
-- BY THE WAY, THE USING KEYWORD'S PARANTHESES CAN HOLD MORE THAN 1 VALUE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- LEFT JOIN shippers sh
-- 	USING (shipper_id)



-- THE USING CLAUSE BUT FOR 2 COLUMNS IN EACH TABLE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- ATTENTION: FOR BELOW QUERY, THERE ARE COMPOSITE PRIMARY KEYS IN ORDER_ITEMS TABLE!
-- SELECT *
-- FROM order_items oi
-- JOIN order_item_notes oin
-- 	USING (order_id, product_id)



-- EXERCISE
-- SELECT 
-- 	p.date,
--     c.name AS client,
--     p.amount,
--     pm.name AS payment_method
-- FROM payments p
-- JOIN clients c USING (client_id)
-- JOIN payment_methods pm
-- 	ON p.payment_method = pm.payment_method_id



-- NATURAL JOINS (MOSH DON'T RECOMMEND THIS CAUSE SOMETIMES IT PRODUCES UNEXPECTED RESULTS)  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- SELECT 
-- 	o.order_id,
--     c.first_name
-- FROM orders o
-- NATURAL JOIN customers c -- the db engine will AUTOMATICALLY combine tables based on columns with same name!



-- CROSS JOINS (EXPLICIT)  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- NOTE: cross joins- used to combine every record of first table with every record of second table!
-- SELECT 
-- 	c.first_name AS customer,
--     p.name AS product
-- FROM customers c
-- CROSS JOIN products p -- cross join don't have on statement cause youre mixing the hell out of everything!
-- ORDER BY c.first_name



-- CROSS JOINS (IMPLICIT, MOSH DON'T RECOMMEND BECAUSE IT'S NOT CLEAR) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- SELECT 
-- 	c.first_name AS customer,
--     p.name AS product
-- FROM customers c, products p -- implicit cross join, no CROSS, no JOIN, no Cristiano Jr. , instead you select from multiple tables in A SINGLE FROM clause!
-- ORDER BY c.first_name



-- UNION (SAME TABLE) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- UNION: COMBINING ROWS FROM MULTIPLE TABLES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- SELECT -- number of col here needa be same with number of col there!!!!!!!!!!!!!!!!!!!!!! SAME WITH DIFFERENT TABLES IN NEXT EXAMPLE!!!!!!!!!!!!!
-- 	order_id,
--     order_date,
--     'Active' AS status -- THIS IS A STRING LITERAL, newly created col name is status, but value is Active!!!!!!!!!!
-- FROM orders
-- WHERE order_date >= '2019-01-01'
-- UNION -- THE UNION OPERATOR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- SELECT 
-- 	order_id,
--     order_date,
--     'Archived' AS status 
-- FROM orders
-- WHERE order_date < '2019-01-01'



-- UNION (DIFFERENT TABLE, BASICALLY ALMOST THE SAME THING) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- SELECT first_name  -- since name clashes, the col in first query gets chosen!
-- FROM customers
-- UNION
-- SELECT name
-- FROM shippers



-- EXERCISE 
-- SELECT 
-- 	customer_id,
--     first_name,
--     points,
--     'Bronze' AS type
-- FROM customers
-- WHERE points < 2000
-- UNION
-- SELECT 
-- 	customer_id,
--     first_name,
--     points,
--     'Silver' AS type
-- FROM customers
-- WHERE points >= 2000 AND points <= 3000
-- UNION
-- SELECT 
-- 	customer_id,
--     first_name,
--     points,
--     'Gold' AS type
-- FROM customers
-- WHERE points > 3000
-- ORDER BY first_name