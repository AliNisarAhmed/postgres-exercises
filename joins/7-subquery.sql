-- How can you output a list of all members, including the individual who recommended them (if any), 
-- without using any joins? 
-- Ensure that there are no duplicates in the list,
-- and that each firstname + surname pairing is formatted as a column and ordered. 

SELECT DISTINCT 
	(ms.firstname || ' ' || ms.surname), 
	(
		SELECT firstname || ' ' || surname
		FROM cd.members AS ms2 
		WHERE ms2.memid = ms.recommendedby
	)
FROM cd.members AS ms;
