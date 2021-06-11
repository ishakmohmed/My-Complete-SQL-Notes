-- equality operator
-- >, <, >=, <=, =, (!= or <>)

--  NOTE: IN THE SQL language, you should enlose dates with quotes!!!!!
-- SELECT * 
-- FROM customers
-- WHERE states <> 'VA' va can be lowercase too, btw, <> means not equal to
-- WHERE birth_date > '1990-01-01' NOTE >>>  year, month, day 
-- There's AND, OR, & NOT operator!
-- note: AND has higher precedence than OR 

-- /////////////////////////////////////////////////////////////////////////////
-- SELECT * 
-- FROM customers
-- WHERE NOT (birth_date >= '1990-01-01' OR points > 1000)  so NOT is applied to >=, OR, & > in this case so each of these are reversed

-- SELECT * 
-- FROM customers 
-- WHERE state NOT IN ('VA', 'FL', 'GA') means state = va or state = fl, etc, REMEMBER THE STUFFS ARE SEPARATED BY COMMAS in "IN" !!!

-- NEW CONCEPT: WHERE points BETWEEN 1000 AND 3000 <<< 1000 and 3000 are inclusive
-- /////////////////////////////////////////////////////////////////////////////

-- SELECT * 
-- FROM customers
-- WHERE last_name LIKE 'b%'  % means any number of character after b, b could be upper/lowercase
-- ^ you can change b% to brush%, or percentage can come infront too, or front and back

-- SELECT *
-- FROM customers
-- WHERE last_name LIKE '%b%'  means include b, but % means any number of character (opposite in underscore)

-- NEW CONCEPT: WHERE last_name LIKE '_____y' means it ends with y with exactly 5 character before it!
-- other example >>> WHERE last_name LIKE 'b____y'

-- SELECT *
-- FROM customers 
-- WHERE address LIKE '%TRAIL%' OR  address LIKE '%AVENUE%'

-- SELECT *
-- FROM customers 
-- WHERE phone NOT LIKE '%9'

-- /////////////////////////////////////////////////

-- THE REGEXP OPERATOR >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- SELECT * 
-- FROM customers 
-- WHERE last_name REGEXP 'field' -- means includes the word field 

-- SELECT * 
-- FROM customers 
-- WHERE last_name REGEXP '^field' -- means must start with field
-- ANOTHER EXAMPLE >> WHERE last_name REGEXP 'field$' -- means must end with field

-- SELECT *
-- FROM customers 
-- WHERE last_name REGEXP '^field|mac|rose' -- no space before and after |
-- in above line the ^ before field applies to field ONLY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP '[gim]e' -- means before e, there should be g or i or m  RIGHT before e
-- you can put the square brackets above after e too
-- or in square brackets you can [a-h]


-- SELECT *
-- FROM customers 
-- WHERE first_name REGEXP 'ELKA|AMBUR'

-- SELECT *
-- FROM customers 
-- WHERE last_name REGEXP 'ey$|on$'

-- SELECT * 
-- FROM customers
-- WHERE last_name REGEXP '^MY|SE'

-- SELECT * 
-- FROM customers
-- WHERE last_name REGEXP 'B[RU]' orrrrrrrrrrrrrrrrr 'br|bu' but initial answer- i guess is better



-- THE IS NULL OPERATOR >>>>>>>>>>>>>>>>>>>>>>>>>>

-- SELECT *
-- FROM customers
-- WHERE phone IS NOT NULL -- you can also not include "NOT" here so it becomes IS NULL

-- SELECT * 
-- FROM orders
-- WHERE shipped_date IS NULL


-- //////////////////////////////////////////////////////////////////////////

-- SELECT first_name, last_name, 10 + 1 AS someNumber       -- 10 + 1 column doesnt exist btw, 
-- ^^^what you're doing is that you add 11 to each record under the newly created column someNumber
-- FROM customers
-- ORDER BY someNumber, first_name -- ORRRRRR ORDER BY 1, 2 so 1 is first column, 2 is second column from SELECT!!!!


-- SELECT *, quantity * unit_price AS total_price
-- FROM order_items
-- WHERE order_id = 2
-- ORDER BY total_price DESC

-- SELECT *
-- FROM customers
-- LIMIT 3 -- if 300 or something, so obv all will be outputted cause this database table has like 10 records or something

-- SELECT *
-- FROM customers
-- LIMIT 6, 3 -- skip first 6 records, and choose 3 records!

-- 3 MOST LOYAL CUSTOMERS BASED ON POINTS!
-- SELECT *
-- FROM customers
-- ORDER BY points DESC
-- LIMIT 3   -- limit clause should come at the end!!!!