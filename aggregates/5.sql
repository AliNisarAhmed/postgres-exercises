-- Produce a list of the total number of slots booked per facility in the month of September 2012. 
-- Produce an output table consisting of facility id and slots, sorted by the number of slots.

SELECT fcs.facid, SUM(bks.slots) AS "Total Slots"
FROM cd.bookings AS bks
INNER JOIN cd.facilities AS fcs on fcs.facid = bks.facid
WHERE EXTRACT(MONTH FROM bks.starttime) = 9 
GROUP BY fcs.facid
ORDER BY "Total Slots";