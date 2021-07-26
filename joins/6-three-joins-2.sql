-- How can you produce a list of bookings on the day of 2012-09-14 which will cost the member (or guest) more than $30?
-- Remember that guests have different costs to members (the listed costs are per half-hour 'slot'), 
-- and the guest user is always ID 0. 
-- Include in your output the name of the facility, the name of the member formatted as a single column, and the cost. 
-- Order by descending cost, and do not use any subqueries. 

SELECT
	ms.firstname || ' ' || ms.surname AS member, 
	fcs.name AS facility,
	(CASE 
		WHEN ms.memid = 0 THEN fcs.guestcost
	 	ELSE fcs.membercost
	 END
	) * bks.slots AS cost
FROM cd.bookings AS bks 
INNER JOIN cd.members AS ms ON ms.memid = bks.memid
INNER JOIN cd.facilities AS fcs ON fcs.facid = bks.facid
WHERE 
	DATE(bks.starttime) = '2012-09-14' AND 
	(CASE 
		WHEN ms.memid = 0 THEN fcs.guestcost * bks.slots > 30
	 	ELSE fcs.membercost * bks.slots > 30
	 END
	)
ORDER BY cost DESC;

-- OR 

select mems.firstname || ' ' || mems.surname as member, 
	facs.name as facility, 
	case 
		when mems.memid = 0 then
			bks.slots*facs.guestcost
		else
			bks.slots*facs.membercost
	end as cost
        from
                cd.members mems                
                inner join cd.bookings bks
                        on mems.memid = bks.memid
                inner join cd.facilities facs
                        on bks.facid = facs.facid
        where
		bks.starttime >= '2012-09-14' and 
		bks.starttime < '2012-09-15' and (
			(mems.memid = 0 and bks.slots*facs.guestcost > 30) or
			(mems.memid != 0 and bks.slots*facs.membercost > 30)
		)
order by cost desc; 