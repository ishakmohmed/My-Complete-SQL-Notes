SELECT 
	DISTINCT first_name, -- distince means unique, so you want unique data only (no repetition)
    last_name, 
    points, 
    (points * 100) + 10 AS 'discount factor', -- quotes single or double if you wanna include space
    state
-- ^ you can also SELECT 1, 2 where these numbers are column names!
-- from, where, and order by are optional  && their order matters
FROM customers