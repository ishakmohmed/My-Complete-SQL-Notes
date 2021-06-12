-- title: Aggregate Functions (take series of values and aggregate them to produce a single value)
-- NOTE: ALL THESE AGGREGATE FUNCTIONS ONLY OPERATE ON NON-NULL VALUES (unless when you COUNT(*))!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT 
	MAX(payment_date) AS highest,     
    -- max payment date is correct, so it returns the latest date!
    MIN(invoice_total) AS lowest, 
	AVG(invoice_total) AS average, 
    SUM(invoice_total * 1.1) AS total,
    COUNT(invoice_total) AS number_of_invoices,
    COUNT(payment_date) AS count_of_payments,
    COUNT(*) AS total_records, 
    -- now youre ignoring the null value
    COUNT(DISTINCT client_id) AS total_records     
    -- you might wanna use DISTINCT with COUNT sometimes if you wanna calc unique stuffs!
FROM invoices  
WHERE invoice_date > '2019-07-01'

 -- **************************************************

-- EXERCISE >>>
SELECT 
	'First half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT 
	'Second half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT 
	'Total' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31'

 -- **************************************************

-- TITLE: GROUP BY clause >>>
-- NOTE: THE ORDER MATTERS, S F W G O H is the order!
SELECT 
	state,
    city,
	SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients 
	USING (client_id)
GROUP BY state, city               
-- means group by every combination of state and city, refer below exercise if you don't understand...yet!

 -- **************************************************

-- EXERCISE >
SELECT 
	   date, 
    name AS payment_method,
    SUM(amount) AS total_payment
FROM payments p
JOIN payment_methods pm
						ON p.payment_method = pm.payment_method_id
GROUP BY date, payment_method
ORDER BY date
 
 -- **************************************************

-- TITLE: THE HAVING CLAUSE >>>>>>>
-- NOTE: with WHERE clause we can filter data before rows are grouped, with HAVING- after grouped && HAVING NEEDA refer cols in SELECT unlike WHERE clause which can refer anything it wants!
SELECT 
	client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(*) AS number_of_invoices
FROM invoices
GROUP BY client_id
HAVING total_sales > 500 AND  number_of_invoices > 5 
-- NOTE: COLUMNS HERE HAVE TO BE A PART OF SELECT CLAUSE UNLIKE THE WHERE CLAUSE!!!!!!!

 -- **************************************************

-- EXERCISE >>>
SELECT 
	c.customer_id,
	c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE c.state = 'VA'
GROUP BY             
-- AS A RULE OF THUMB, when you have AGGREGATE FUNCTION in SELECT statement (SUM, AVG, etc.), and you're grouping data, group by all the columns in the SELECT clause like right now!
	c.customer_id,
	c.first_name,
    c.last_name
HAVING total_sales > 100        
-- AGAIN, needa be part of SELECT clause unlike the WHERE clause!

 -- **************************************************

-- TITLE: THE ROLLUP (WITH ROLLUP) OPERATOR >>>
-- ROLLUP (WITH ROLLUP) is only available in mysql, is not a part of the standart sql language!
-- The GROUP BY clause permits a WITH ROLLUP modifier that causes summary output...
-- ...to include extra rows that represent higher-level (that is, super-aggregate) summary operations.
-- IMPORTANT: when you have GROUP BY with WITH ROLLUP, then the col name in between these 2 needa be the actual name, not alias!

SELECT 
	state, 
    city, 
    SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients c USING (client_id)
GROUP BY state, city WITH ROLLUP      
-- WITH ROLLUP, not for city only (which cannot be summarized by ROLLUP), but for all cols that aggregate values!

-- CONCLUSION: THE ROLLUP OPERATOR CALCULATES THE SUMMARY FOR EACH GROUP (AND ENTIRE RESULT SET)
-- NOT ENTIRE SURE ABOUT THIS ONE, I GUESS: i guess in rollup, if 1 value, then that value is outputted although its not aggregatable value

-- **************************************************

-- EXERCISE 

SELECT 
	pm.name AS payment_method,
    SUM(p.amount) AS total
FROM payments p
JOIN payment_methods pm ON p.payment_method = pm.payment_method_id
GROUP BY pm.name WITH ROLLUP   
-- column name cannot be alias because you've got WITH ROLLUP
