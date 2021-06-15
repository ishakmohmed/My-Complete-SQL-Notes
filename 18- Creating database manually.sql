-- Creating DB manually >>>

CREATE DATABASE IF NOT EXISTS sql_store2;
-- DROP DATABASE IF EXISTS sql_store2;

USE sql_store2;

-- DROP TABLE IF EXISTS customers or CREATE TABLE IF NOT EXISTS customers (actually you can use both)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE IF NOT EXISTS customers
(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    points INT NOT NULL DEFAULT 0,
    email VARCHAR (255) NOT NULL UNIQUE
);

-- **************************************************

-- Altering tables >>>

ALTER TABLE customers 
	ADD last_name VARCHAR(50) NOT NULL AFTER first_name,
    ADD city	  VARCHAR(50) NOT NULL,
    MODIFY COLUMN first_name VARCHAR(55) DEFAULT '',
    DROP points;
    
-- **************************************************

-- Creating relationships >>>

CREATE TABLE ORDERS 
(
	order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    FOREIGN KEY fk_orders_customers (customer_id)
		REFERENCES customers (customer_id)
        ON UPDATE CASCADE
        -- ON UPDATE / ON DELETE > CASCASE / SET NULL / NO ACTION
        ON DELETE NO ACTION
);

-- **************************************************

-- Altering primary & foreign key constraints >>>

ALTER TABLE orders
	ADD PRIMARY KEY (order_id),
    DROP PRIMARY KEY,
    DROP FOREIGN KEY fk_orders_customers,
    ADD FOREIGN KEY fk_order_customers (customer_id)
		REFERENCES customers (customer_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION;

-- **************************************************

-- Character sets & collations >>>

SHOW CHARSET;

-- to change it (which you don't need to in 99% cases), using MySQL workbench, use the schema inspector
-- manual way (usually you'd do it at database level) >

CREATE DATABASE db_name
-- CREATE/ALTER
	CHARACTER SET latin1;
    
-- or >

-- CREATE TABLE table1
-- CREATE/ALTER
-- (
-- 	-- ...
-- )
-- CHARACTER SET latin1;

-- or >

-- CREATE TABLE table2
-- CREATE/ALTER
-- (
-- first_name VARCHAR(50) CHARACTER SET latin1 NOT NULL
-- )

-- **************************************************

-- Storage engines 

SHOW ENGINES;

-- or 

ALTER TABLE customers
ENGINE = InnoDB;

-- InnoDB is the newer, more popular storage engine (it supports transactions and other features)