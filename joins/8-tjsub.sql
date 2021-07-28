-- The "Produce a list of costly bookings" exercise contained some messy logic: 
	-- we had to calculate the booking cost in both the WHERE clause and the CASE statement. 
	-- Try to simplify this calculation using subqueries. For reference, the question was:

-- How can you produce a list of bookings on the day of 2012-09-14 which will cost the member (or guest) more than $30? 
-- Remember that guests have different costs to members (the listed costs are per half-hour 'slot'), 
-- and the guest user is always ID 0. 
-- Include in your output the name of the facility, the name of the member formatted as a single column, and the cost. 
-- Order by descending cost. 

SELECT
	member,
	name,
	cost
FROM (
	SELECT 
		ms.firstname || ' ' || ms.surname AS member,
		fcs.name AS name,
		(
			CASE 
				WHEN ms.memid = 0 THEN bks.slots * fcs.guestcost
	 			ELSE bks.slots * fcs.membercost
	 		END
		) AS cost
	FROM cd.bookings AS bks
	INNER JOIN cd.members AS ms on ms.memid = bks.memid
	INNER JOIN cd.facilities AS fcs ON fcs.facid = bks.facid
	) AS bookings
WHERE cost > 30 
ORDER BY cost DESC;