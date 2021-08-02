-- Find the total number of members (including guests) who have made at least one booking.

SELECT COUNT(*) 
FROM (
SELECT ms.memid
	FROM cd.members AS ms 
	INNER JOIN cd.bookings AS bks ON bks.memid = ms.memid 
	GROUP BY ms.memid
) AS rows;

-- OR, far better and simple 

SELECT COUNT(DISTINCT memid) FROM cd.bookings;