-- Produce a list of facilities with a total revenue less than 1000.
-- Produce an output table consisting of facility name and revenue, sorted by revenue. 
-- Remember that there's a different cost for guests and members!

SELECT
	name, revenue 
FROM 
	(
		SELECT fcs.name, SUM(
			bks.slots * 
				CASE 
					WHEN bks.memid = 0 THEN guestcost
					ELSE membercost
				END
		) AS revenue
		FROM cd.facilities AS fcs 
		INNER JOIN cd.bookings AS bks ON bks.facid = fcs.facid
		GROUP BY fcs.name 
	) AS aggregate 
WHERE revenue < 1000
ORDER BY revenue;
