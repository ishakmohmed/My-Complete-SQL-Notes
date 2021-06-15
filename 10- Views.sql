-- Views >>>

USE sql_invoicing;

CREATE VIEW sales_by_client AS
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total) AS total_sales
FROM clients c 
JOIN invoices i USING (client_id)
GROUP BY client_id, name; 

-- now you can use this view like how you've done all while, but remember views don't store data, tables do!

-- **************************************************

-- Exercise >>>

USE sql_invoicing;
CREATE OR REPLACE VIEW clients_balance AS
-- "OR REPLACE" is optional
-- also, you can > DROP VIEW clients_balance to drop this view
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total - payment_total) AS balance
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY  client_id, name;

-- **************************************************

-- Updatable views >>>
-- but for a view to be updatable, it cannot contain:
-- DISTINCT
-- Aggregate functions (MIN, MAX, SUM, etc.)
-- GROUP BY / HAVING
-- UNION

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION;
-- ^ WITH CHECK OPTION is optional and it'll prevent (by prevent I mean it'll throw error) updating/deleting view from making rows(s) disappear from view

DELETE FROM invoices_with_balance
WHERE invoice_id = 1;

UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invoice_id = 2;
