-- Produce a list of facilities along with their total revenue. 
-- The output table should consist of facility name and revenue, sorted by revenue. 
-- Remember that there's a different cost for guests and members! 

SELECT 
	fcs.name,
	SUM(
		CASE 
			WHEN bks.memid = 0 THEN fcs.guestcost * bks.slots
			ELSE fcs.membercost * bks.slots
		END
	) AS revenue
FROM cd.facilities AS fcs 
INNER JOIN cd.bookings AS bks ON bks.facid = fcs.facid
GROUP BY fcs.facid
ORDER BY revenue;