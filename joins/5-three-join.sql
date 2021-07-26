-- How can you produce a list of all members who have used a tennis court? 
-- Include in your output the name of the court, and the name of the member formatted as a single column. 
-- Ensure no duplicate data, and order by the member name followed by the facility name. 

SELECT DISTINCT CONCAT(ms.firstname, ' ', ms.surname) AS member, fcs.name AS facility
FROM cd.members AS ms 
INNER JOIN cd.bookings bks ON bks.memid = ms.memid 
INNER JOIN cd.facilities fcs on bks.facid = fcs.facid 
WHERE fcs.name LIKE 'Tennis%'
ORDER BY member, fcs.name;

-- OR 

SELECT DISTINCT mems.firstname || ' ' || mems.surname AS member, facs.name as facility
	FROM 
		cd.members mems
		INNER JOIN cd.bookings bks
			ON mems.memid = bks.memid
		INNER JOIN cd.facilities facs
			ON bks.facid = facs.facid
	WHERE
		facs.name in ('Tennis Court 2','Tennis Court 1')
ORDER BY member, facility     