-- Triggers >>>

DELIMITER $$

DROP TRIGGER IF EXISTS payments_after_insert;
-- above line is optional but ideal. 'IF EXISTS' is optional but ideal

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    -- in this trigger, we can modify data in any table except the table this trigger is for
    -- AFTER/BEFORE, INSERT/UPDATE/DELETE
    FOR EACH ROW
    
BEGIN 
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    -- NEW/OLD
    WHERE invoice_id = NEW.invoice_id;
END $$

DELIMITER ;

-- I'm gonna update payments, but invoice will get updated too, thanks to trigger >

INSERT INTO payments
VALUES (DEFAULT, 5, 3, '2019-01-01', 10, 1)

-- **************************************************

-- Exercise >>>

DELIMITER $$

DROP TRIGGER IF EXISTS payments_after_delete;

CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
END $$

DELIMITER ;

-- **************************************************

-- Viewing triggers >>>

-- table_before/after_insert/delete/update

SHOW TRIGGERS;

-- or >

SHOW TRIGGERS LIKE 'payments%';

-- **************************************************

-- Using triggers for auditing (gonna reuse code above)

DELIMITER $$

DROP TRIGGER IF EXISTS payments_after_insert;

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
    
BEGIN 
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
    
    INSERT INTO payments_audit
    VALUES(NEW.client_id, NEW.date, NEW.amount, 'Insert', NOW());
END $$

DELIMITER ;

DELIMITER $$

DROP TRIGGER IF EXISTS payments_after_delete;

CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
    
	INSERT INTO payments_audit
    VALUES(OLD.client_id, OLD.date, OLD.amount, 'Delete', NOW());
END $$

DELIMITER ;

-- **************************************************

-- Events >>>

SHOW VARIABLES LIKE 'event%';
SET GLOBAL event_scheduler = ON;
-- event_scheduler is turned on by default, but some organization might turn it off to save system resources


-- Creating an event >>>

DELIMITER $$

CREATE EVENT yearly_delete_state_audit_rows
ON SCHEDULE
	-- AT '2019-05-01'
    -- EVERY 1 HOUR
    -- EVERY 2 DAYS
    EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01';
    -- Note: STARTS & ENDS are optional 
DO BEGIN
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
    -- or use DATEADD(NOW(), INTERVAL -1 YEAR) 
    -- or use DATESUB()
END $$

DELIMITER ;
    
-- **************************************************

-- Viewing, dropping, and altering events >>>

SHOW EVENTS;
SHOW EVENTS LIKE 'yearly%';
-- of couse, for ^ this to work, needa follow the convention

DROP EVENT IF EXISTS yearly_delete_stale_audit_rows;


-- you can also > ALTER EVENT... and the syntax is similar with CREATE EVENT
-- or >
ALTER EVENT yearly_delete_stale_audit_rows ENABLE;    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    





