-- How can you output a list of all members, including the individual who recommended them (if any)? 
-- Ensure that results are ordered by (surname, firstname). 

SELECT 
	ms.firstname AS memfname, 
	ms.surname AS memsname, 
	rs.firstname AS recfname,
	rs.surname AS recsname 
FROM cd.members AS ms
LEFT OUTER JOIN cd.members AS rs ON ms.recommendedby = rs.memid
ORDER BY ms.surname, ms.firstname;