-- We want to alter the price of the second tennis court so that it costs 10% more than the first one. 
-- Try to do this without using constant values for the prices, so that we can reuse the statement if we want to.


UPDATE cd.facilities 
SET guestcost = 1.1 * (SELECT guestcost FROM cd.facilities WHERE name = 'Tennis Court 1'),
	membercost = 1.1 * (SELECT membercost FROM cd.facilities WHERE name = 'Tennis Court 1')
WHERE 
	name = 'Tennis Court 2';
	
-- OR 

update cd.facilities facs
    set
        membercost = facs2.membercost * 1.1,
        guestcost = facs2.guestcost * 1.1
    from (select * from cd.facilities where facid = 0) facs2
    where facs.facid = 1;