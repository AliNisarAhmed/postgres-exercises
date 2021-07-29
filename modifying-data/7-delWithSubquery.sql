-- Delete all members who have never made a booking

DELETE FROM 
cd.members 
WHERE memid NOT IN (
	SELECT memid FROM cd.bookings
);