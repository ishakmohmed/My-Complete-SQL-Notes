-- Securing databases >>>

-- CREATE USER john@127.0.0.1
-- CREATE USER john@localhost
-- CREATE USER john@codewithmosh.com
-- CREATE USER john@'%.codewithmosh.com'
-- CREATE USER john 

CREATE USER john IDENTIFIED BY '1234';
DROP user bob@codewithmosh.com;
-- bob@codewithmosh.com doesn't exist

-- **************************************************

-- Viewing users >>>

SELECT * FROM mysql.user;

-- **************************************************

-- Changing passwords >>>

-- for currently logged in user >
SET PASSWORD = '1234';

-- for other users >
SET PASSWORD FOR john = '1234';

-- **************************************************

-- Granting privileges >>>

-- 1: web/desktop application >
CREATE USER moon_app IDENTIFIED BY '1234';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE
ON sql_store.*
TO moon_app;

-- 2: admin
GRANT ALL
-- or Google privileges in MySQL
ON *.*
TO john;

-- **************************************************

-- Viewing privileges >>>

SHOW GRANTS;
-- ^ for current user
SHOW GRANTS FOR john;

-- **************************************************

-- Revoking privileges >>>

REVOKE CREATE VIEW 
ON sql_store.*
FROM moon_app;