INSERT INTO customers 
-- optionally, you can specify which columns you wanna insert data into, and then insert to just those cols, and you can mix up the orders.
VALUES (DEFAULT,
		'John',
        'Smith',
        '1990-01-01',
        NULL, 
        -- or DEFAULT cause default is NULL in this table!
		'address',
        'city',
        'CA',
        DEFAULT);

 -- **************************************************

INSERTING MULTIPLE ROWS >>>
INSERT INTO shippers(name)
VALUES ('Shipper1'),
		('Shipper2'),
        ('Shipper3')

-- **************************************************

-- EXERCISE 
INSERT INTO products (name, quantity_in_stock, unit_price)
VALUES ('Product1', 10, 1.95),
	('Product2', 11, 1.95),
    ('Product3', 12, 1.95)

-- **************************************************

-- TITLE : INSERTING HIERARCHICAL ROWS (INSERTING DATA INTO MULTIPLE TABLES)
-- 1 ROW IN ORDER TABLE CAN HAVE  >= 1 ROW IN ORDER ITEMS TABLE! [parent-child relationship], where parent- order table, order_items- child!
-- ^^ CONTINUE: I guess like when you go to store you can purchase different orderItems under 1 orderId!!!

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1); 
-- need to insert valid customerID && status!

-- NOTE: JUST IN CASE YOU'RE REVISING THIS, THE LAST_INSERT_ID IN ORDERS TABLE (1 TIME) AND ORDERITEMS TABLE (2 TIMES) IS 11 OR ELEVEN WHICH IS ORDER_ID in both tables!!!

INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 2.95), 
-- LAST_INSERT_ID: will return the id that mysql generates when we insert a new row.
		(LAST_INSERT_ID(), 2, 1, 3.95)

-- CONCLUSION: OMG ITS SO SIMPLE >>> so under 1 unique order_id in ORDER table, there are 2 items in order_items table under the same unique order id (not unique in this table anymore)!

-- **************************************************

-- TITLE: CREATING A COPY OF A TABLE (initially copied and then truncated, then added some custom stuffs)

CREATE TABLE orders_archived AS 
-- using this method, you can copy a table's data but not the primary key, auto increment, and stuffs like that, like the configuration!
SELECT * FROM orders 
-- this select statement is a subquery- a select statement that is a part of another SQL statement!

-- **************************************************

INSERT INTO orders_archived
SELECT * -- also a subquery!
FROM orders 
WHERE order_date < '2019-01-01'

-- **************************************************

-- EXERCISE (DROPPED THE NEWLY CREATED invoices_archived table but you can undo commented code below to generate it back)
USE sql_invoicing;

CREATE TABLE invoices_archived AS
SELECT i.invoice_id,
		i.number,
        c.name AS client,
        i.invoice_total,
        i.payment_total,
        i.invoice_date,
        i.payment_date,
        i.due_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE i.payment_date IS NOT NULL

-- **************************************************

-- TITLE: UPDATING A SINGLE ROW >>>>>>>>>>>>>>>>>>>
-- NOTE: when you wanna update something, you set stuffs, update? set!, update = set, set existing stuffs!

UPDATE invoices
SET payment_total = DEFAULT, payment_date = NULL 
WHERE invoice_id = 1

UPDATE invoices 
SET 
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE invoice_id = 3

-- **************************************************

-- TITLE: UPDATING MULTIPLE ROWS (same like single row, just make "WHERE" more general)>>>>>>>>>>>>>>>>>>>>>>>>>>>>
UPDATE invoices 
SET 
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id = 3 -- you can even do something like >>> client_id IN (3, 4)