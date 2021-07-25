-- How can you produce a list of the start times for bookings by members named 'David Farrell'? 

SELECT starttime FROM cd.bookings AS bookings
INNER JOIN cd.members AS members ON members.memid = bookings.memid 
WHERE 
members.firstname = 'David'
AND 
members.surname = 'Farrell';

-- OR 

SELECT starttime 
FROM cd.bookings
INNER JOIN cd.members on members.memid = bookings.memid
WHERE CONCAT(cd.members.firstname, ' ', cd.members.surname) = 'David Farrell';