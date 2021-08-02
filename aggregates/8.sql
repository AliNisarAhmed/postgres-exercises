-- Produce a list of facilities with more than 1000 slots booked. 
-- Produce an output table consisting of facility id and slots, sorted by facility id.

SELECT fcs.facid, SUM(bks.slots)
FROM cd.facilities AS fcs 
INNER JOIN cd.bookings AS bks ON bks.facid = fcs.facid 
GROUP BY fcs.facid
HAVING SUM(bks.slots) > 1000
ORDER BY fcs.facid;

