-- Produce a list of the total number of hours booked per facility, remembering that a slot lasts half an hour. 

-- The output table should consist of the facility id, name, and hours booked, sorted by facility id. 

-- Try formatting the hours to two decimal places. 

SELECT fcs.facid, fcs.name, TRIM(TO_CHAR(SUM(bks.slots) / 2.0, 'FM9999999D00')) AS "Total Hours"
FROM cd.facilities AS fcs 
INNER JOIN cd.bookings AS bks ON bks.facid = fcs.facid 
GROUP BY fcs.facid, fcs.name
ORDER BY fcs.facid;
