-- Stored procedures >>>

DELIMITER $$
-- the DELIMITER can be anything, but $$ is the convention
CREATE PROCEDURE get_clients()
BEGIN
	SELECT * FROM clients;
END$$

DELIMITER ;
-- finally needa change the default delimiter back to semicolon and this is only in MySQL
-- now you can call this stored procedure like > CALL get_clients()

-- **************************************************

-- Exercise >>>

DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance()
BEGIN
	SELECT *
    FROM invoices_with_balance
    WHERE balance > 0;
END$$

DELIMITER ;

-- Note: you can also create stored procedures using MySQL Workbench easily, just revisit the tutorial in case you forgot how to do it!

-- **************************************************

-- Dropping stored procedures >>>

DROP PROCEDURE IF EXISTS get_clients;
-- "IF EXISTS" is optional 
-- implement stored procedure here...

-- **************************************************

-- Parameters >>>

DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
	state CHAR(2)
)
BEGIN
	SELECT * FROM clients c
    WHERE c.state = state;
END $$

DELIMITER ;

-- this is how you call it:
CALL get_clients_by_state('CA');

-- **************************************************

-- Parameters with default value >>>

DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
	state CHAR(2)
)
BEGIN
	IF state IS NULL THEN
		SET state = 'CA';
	END IF;

	SELECT * FROM clients c
    WHERE c.state = state;
END $$

DELIMITER ;

CALL get_clients_by_state('CA');

-- **************************************************

-- a better way >>>

DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
	state CHAR(2)
)
BEGIN
	IF state IS NULL THEN
		SELECT * FROM clients;
	ELSE
		SELECT * FROM clients c
		WHERE c.state = state;
END IF;

DELIMITER ;

CALL get_clients_by_state('CA');

-- **************************************************

-- this is even better >>>

DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
	state CHAR(2)
)
BEGIN 
	SELECT * FROM clients c
    WHERE c.state = IFNULL(state, c.state);
END $$

DELIMITER ;

CALL get_clients_by_state('CA');

-- **************************************************

-- Note: in stored procedures, right after BEGIN, you can add parameter validation, 
-- here's how (but I'm not gonna write the entire code) >

-- ...
-- BEGIN
-- 	IF payment_amount <= 0 THEN
--   SIGNAL SQLSTATE '22003' SET MESSAGE_TEXT = 'Invalid payment amount';
-- END IF;
	-- Note: I bookmarked a site on Chrome by IBM to refer to SQLSTATE error codes (recommended by Mosh)
  
--    -- UPDATE whatever...

-- **************************************************

-- Output parameters >>>

CREATE PROCEDURE get_unpaid_invoices_for_client
(
	client_id INT,
    OUT invoices_count INT,
    OUT invoices_total DECIMAL(9, 2)
)
BEGIN 
	SELECT COUNT(*), SUM(invoice_total)
    -- we're reading ^ these values and copying them into these parameters >
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id
    AND payment_total = 0;
END

-- Of course, there's an error here cause we needa write more stuffs like the delimiter and stuffs, but you get the point
-- the way to read the output parameters is by using '@', it's pretty complicated and unnecessary, revisit the tutorial if you need to use it, but you wouldn't need it pretty much

-- **************************************************

-- Variables >>>

CREATE PROCEDURE get_risk_factor ()
BEGIN 
	DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9, 2);
    DECLARE invoices_count INT;
    
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices;
    
    SET risk_factor = invoices_total / invoices_count * 5;
    
    SELECT risk_factor;
    
END

-- **************************************************

-- Functions (can only return a single value) >>>
-- the following code only works in the MySQL workbench tool that creates functions

DROP FUNCTION IF EXISTS get_risk_factor_for_client;

CREATE FUNCTION get_risk_factor_for_client 
(
	client_id INT
)
RETURNS INTEGER
-- DETERMINISTIC
READS SQL DATA
MODIFIES SQL DATA
BEGIN
	DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9, 2);
    DECLARE invoices_count INT;
    
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id;
    
    SET risk_factor = invoices_total / invoices_count * 5;
RETURN IFNULL(risk_factor, 0);
END
