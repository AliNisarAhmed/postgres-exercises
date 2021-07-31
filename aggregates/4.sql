-- Produce a list of the total number of slots booked per facility. 
-- For now, just produce an output table consisting of facility id and slots, sorted by facility id.

SELECT fcs.facid, SUM(bks.slots)
FROM cd.facilities AS fcs 
INNER JOIN cd.bookings AS bks ON bks.facid = fcs.facid
GROUP by fcs.facid 
ORDER BY fcs.facid;
