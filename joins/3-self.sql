-- How can you output a list of all members who have recommended another member? 
-- Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).

SELECT DISTINCT ms1.firstname, ms1.surname 
FROM cd.members AS ms1 
INNER JOIN cd.members ms2 ON ms1.memid = ms2.recommendedby
ORDER BY surname, firstname;