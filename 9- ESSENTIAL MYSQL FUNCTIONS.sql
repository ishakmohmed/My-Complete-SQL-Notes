-- NUMERIC FUNCTIONS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- SELECT ROUND(5.7345, 2), -- right is decimal place, and it's optional
-- TRUNCATE(5.777, 2),  -- means no rounding of, rather you just keep 2 decimal places, FMI needa specify DP
-- CEILING(5.667),
-- FLOOR(5.346544),
-- ABS(-5.5), -- absolute value
-- RAND() -- random floating point number between 0 and 1


-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


-- String Functions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- SELECT 
-- 	LENGTH('sky'), -- length of character
--     UPPER('sKy'), -- to all upper
--     LOWER('SKY'), -- to all lower
--     LTRIM('     ok'),
--     RTRIM('ok       '),
--     TRIM('     ok       '), -- means both left and right()
--     LEFT('kindergarten', 5),  -- 5 character from left
--     RIGHT('kindergarten', 6), 
--     SUBSTRING('kindergarten', 2, 4), -- from position 2 (start from 1 not 0), take 4 characters (length), if you don't specify the 3rd arg, it takes all till end of str. 
--     LOCATE('N', 'kindergarten'), -- returns the first occurence, AND NOT CASE SENSITIVE!!!
-- 	LOCATE('X', 'kindergarten'), -- returns 0 if it doenst exist, unlike most of the other programming languages
--     LOCATE('garten', 'kindergarten'), -- LISTEN, YOU CAN ALSO SEARCH FOR SEQUENCE OF CHARACTERS LIKE WORDS HERE
--     REPLACE('kindergarten', 'garten', 'ABCDEF'),
--     CONCAT('first', ' ', 'last', '         ', 'superLast') -- or you can use column names



-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


-- DATE FUNCTIONS IN MYSQL >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- SELECT 
-- 	NOW(),    -- both currect date and current time
--     CURDATE(),
--     CURTIME(),
--     
--     -- ALL THESE RETURN INTEGER VALUES >>>>>>>>>>
--     YEAR(NOW()),
--     MONTH(NOW()),
--     DAY(NOW()),
--     HOUR(NOW()),
--     MINUTE(NOW()),
--     SECOND(NOW()), 
--     
--     
-- 	DAYNAME(NOW()),   -- string > Saturday
--     MONTHNAME(NOW()),   -- string > August
--     
--     
--     -- EXTRACT IS A PART OF THE STANDARD SQL LANGUAGE, so if you wanna be able to port your code to other DBMS, it's better to use the extract function
--     EXTRACT(DAY FROM NOW()),
--     EXTRACT(YEAR FROM NOW())

-- EXERCISE >>>>>>>>>>>>>
-- SELECT *
-- FROM orders
-- WHERE YEAR(order_date) = YEAR(NOW())
-- NOTE: IT'S NOT GONNA RETURN ANY RECORD, BUT THIS QUERY IS PERFECT!


-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

-- FORMATTING DATES AND TIMES >>>>>>>>>>>>
-- DATE_FORMAT >>>>>>
-- SELECT DATE_FORMAT(NOW(), '%y  %m %M  %Y    %d') -- 2 args, date value and format string

-- %y means 2 digit year
-- %Y means 4 digit year
-- %m means 2 digit month
-- %M means month name
-- %d for day

-- TIME_FORMAT >>>
-- SELECT TIME_FORMAT(NOW(), '%H:%i %p') -- hour, colon, minutes, "PM" <<< it literally displays "PM"
-- %H means 24-hour format
-- %h means 12-hour format


-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


-- CALCULATING DATES AND TIMES >>>>>>>>>>>
-- SELECT DATE_ADD(NOW(), INTERVAL 1 DAY),
-- DATE_ADD(NOW(), INTERVAL 1 YEAR),
-- DATE_ADD(NOW(), INTERVAL -5 DAY),
-- DATE_SUB(NOW(), INTERVAL 5 DAY),  -- instead of -5 like in above line, im using a dedicated DATE_SUB fn for it!
-- DATEDIFF('2019-01-05 09:00', '2019-01-01 17:00'), -- but it'll only return difference in days (EVEN IF YOU INCLUDE TIME VALUE LIKE IN HERE)
-- -- ^^^^ if you early date minus later date, you'll get negative value, basically 1st value - 2nd value!
-- TIME_TO_SEC('09:00') - TIME_TO_SEC('09:02') -- means seconds elapsed since midnight minus another seconds elapsed since midnight


-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

-- THE IFNULL AND COALESCE FUNCTIONS >>>>>>
-- SELECT 
-- 	order_id, 
-- 	IFNULL(shipper_id, 'Not assigned') AS shipper,    -- if value is null, replace with....
-- 	COALESCE(shipper_id, comments, 'Not assigned') AS someColName -- if shipper_id is null, return comment, if comments is null too, then return 'Not assigned', basically COALESCE returns the first non NULL value FROM THE LIST OF VALUES!
-- FROM orders
-- ORDER BY order_id



-- EXERCISE >>>>>>>>>
-- SELECT CONCAT(first_name, ' ', last_name) AS customer,
-- 		IFNULL(phone, 'UNNNKNNOOWWNN') AS phone   -- you can also use COALESCE() with these exact same args (2 args)
-- 	FROM customers


-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

-- THE IF FUNCTION >>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- SELECT 
-- 	order_id, 
--     order_date, 
--     IF(YEAR(order_date) = YEAR(NOW()), 'Active', 'Archived') AS category
-- FROM orders

-- EXERCISE >>>>>>>>>>>>>>>>
-- SELECT 
-- 	product_id,
--     name,
--     COUNT(*) AS orders,
--     IF(COUNT(*) > 1, 'Many times', 'Once') AS frequency
-- FROM products
-- JOIN order_items USING (product_id)
-- GROUP BY product_id, name


-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


-- THE CASE OPERATOR >>>>>>>>>>>>>>>>>>>>>>>>>>
-- SELECT 
-- 	order_id,
--     CASE
-- 		WHEN YEAR(order_date) = YEAR(NOW()) THEN 'Active'
-- 		WHEN YEAR(order_date) = YEAR(NOW()) - 1 THEN 'Last Year'
-- 		WHEN YEAR(order_date) < YEAR(NOW()) - 1 THEN 'Archived'
--         ELSE 'I guess future it is'        -- ELSE is optional by the way!
-- 	END AS category       -- you must close the CASE with END AS [whatever column name]
-- FROM orders


-- EXERCISE >>>>>>>>>>>>>>>>>>>>
-- SELECT 
-- 	concat(first_name, ' ', last_name) AS customer,
--     points,
--     CASE
-- 		   WHEN (points > 3000) THEN 'Gold'    --  no comma after end of each case
--         WHEN (points >= 2000) THEN 'Silver'      -- no comma after end of each case
--         ELSE 'Bronze'
-- 	END AS 'category'
-- FROM customers	
