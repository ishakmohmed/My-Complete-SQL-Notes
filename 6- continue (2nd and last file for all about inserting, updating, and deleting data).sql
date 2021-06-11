-- EXERCISE 

-- UPDATE customers
-- SET points = points + 50
-- WHERE birth_date < '1990-01-01'









-- TITLE: USING SUBQUERIES IN UPDATES!
-- USE sql_invoicing;

-- UPDATE invoices
-- SET
-- 	payment_total = invoice_total * 0.5,
--     payment_date = due_date
-- WHERE client_id IN -- ############### because the subquery returns multiple records, we're using IN instead of =
-- 	(SELECT client_id         
--     FROM clients
--     WHERE state IN ('CA', 'NY'))  -- this is a subquery cause its a select statement within another SQL statement
                
       

-- EXERCISE TIME >>>>>>>>>>>>>>>>>>>
-- UPDATE orders
-- SET comments = 'GOLD CUSTOMER'
-- WHERE customer_id IN         -- use IN not equals=, cause subquery returns multiple records!
-- 				(SELECT customer_id 
--                 FROM customers
--                 WHERE points > 3000) 












-- TITLE: DELETING ROWS!
-- DELETE FROM invoices      -- if you only write this line, all records will be deleted!
-- WHERE client_id = (     -- this line is optional!
-- 	SELECT *      -- I guess in subquery when you're deleting, just select *All ????????
--     FROM clients
--     WHERE name = 'Myworks'
-- )











       
                
                
                