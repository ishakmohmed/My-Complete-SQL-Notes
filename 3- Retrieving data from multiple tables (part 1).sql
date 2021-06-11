-- INNER JOIN >>>

SELECT order_id, o.customer_id, first_name, last_name 
-- can mix up, unless both table have same col name, needa use prefix
FROM orders o 
-- orders as alias o, so replace order with o 
JOIN customers c    
-- INNER keyword is optional
	ON o.order_id = c.customer_id

-- **************************************************

SELECT order_id, oi.product_id, p.name, quantity, oi.unit_price 
-- sometimes in 2 diff tables, 2 col with same name but dif values, choose accordingly
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id

-- **************************************************

SELECT *
FROM order_items oi
JOIN  sql_inventory.products pr   
-- prefixing with sql_inventory cause this table is in that db AND I'M WRITING THIS QUERY IN SQL_STORE 
	ON oi.product_id = pr.product_id

-- **************************************************

-- SELF JOIN >>>

SELECT 
	emp.employee_id,
    emp.first_name,
    mgr.first_name AS 'Manager Name'
FROM employees emp
JOIN employees mgr
	ON emp.reports_to = mgr.employee_id 
-- ohhhh employees' boss' id same with boss' own id 

-- **************************************************

-- JOINING MULTIPLE TABLES >>>

SELECT
	o.order_id, 
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id

-- **************************************************

SELECT
	p.date,
    p.invoice_id,
    p.amount,
    c.name,
    pm.name
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id

-- **************************************************

-- JOINING TABLES WITH COMPOSITE PRIMARY KEYS >>>
SELECT * 
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_Id
    AND oi.product_id = oin.product_id