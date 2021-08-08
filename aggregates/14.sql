-- Produce a list of each member name, id, and their first booking after September 1st 2012. 

-- Order by member ID. 

SELECT surname, firstname, mcs.memid, MIN(bks.starttime)
FROM cd.members AS mcs
INNER JOIN cd.bookings AS bks ON bks.memid = mcs.memid
WHERE starttime > '2012-09-01'
GROUP BY surname, firstname, mcs.memid
ORDER BY memid;