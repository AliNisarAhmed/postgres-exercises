-- Output the facility id that has the highest number of slots booked. 

-- For bonus points, try a version without a LIMIT clause. This version will probably look messy! 

SELECT fcs.facid, SUM(slots) AS "Total Slots"
FROM cd.facilities AS fcs
INNER JOIN cd.bookings AS bks ON bks.facid = fcs.facid 
GROUP BY fcs.facid
ORDER BY SUM(slots) DESC
LIMIT 1;


-- Without HAVING - version 1

SELECT facid, SUM(slots) AS totalslots 
FROM cd.bookings 
GROUP BY facid
HAVING SUM(slots) = (
	SELECT MAX(sum2.totalslots) FROM 
		(
			SELECT SUM(slots) AS totalslots 
			FROM cd.bookings
			GROUP BY facid 
	 	) AS sum2
);

-- without HAVING -- version 2  -- Using CTEs

WITH sum AS (
	SELECT facid, SUM(slots) AS totalslots
	FROM cd.bookings
	GROUP BY facid
)

SELECT facid, totalslots
FROM sum 
WHERE totalslots = (SELECT MAX(totalslots) FROM sum);




	



