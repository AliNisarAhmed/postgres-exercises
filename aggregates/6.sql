-- Produce a list of the total number of slots booked per facility per month in the year of 2012. 
-- Produce an output table consisting of facility id and slots, sorted by the id and month. 

SELECT 
	fcs.facid, 
	EXTRACT(MONTH FROM bks.starttime) AS month, 
	SUM(bks.slots) AS "Total Slots"
FROM cd.facilities AS fcs 
INNER JOIN cd.bookings AS bks ON bks.facid = fcs.facid 
WHERE EXTRACT(YEAR FROM bks.starttime) = 2012
GROUP BY fcs.facid, month
ORDER by facid, month;