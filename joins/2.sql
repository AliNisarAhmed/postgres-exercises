-- How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? 
-- Return a list of start time and facility name pairings, ordered by the time.

SELECT bks.starttime, fcs.name
FROM cd.bookings AS bks 
INNER JOIN cd.facilities AS fcs ON fcs.facid = bks.facid
WHERE DATE(bks.starttime) = '2012-09-21' AND fcs.name LIKE 'Tennis%'
ORDER BY starttime;

-- OR (notice the cast of Timestamp to Date)

SELECT b.starttime AS start, f.name AS name 
FROM cd.bookings AS b 
INNER JOIN cd.facilities AS f ON f.facid = b.facid
WHERE CAST(b.starttime AS DATE) = '2012-09-21'AND f.name like 'Tennis%'
ORDER BY b.starttime;

-- OR 

select bks.starttime as start, facs.name as name
	from 
		cd.facilities facs
		inner join cd.bookings bks
			on facs.facid = bks.facid
	where 
		facs.name in ('Tennis Court 2','Tennis Court 1') and
		bks.starttime >= '2012-09-21' and
		bks.starttime < '2012-09-22'
order by bks.starttime; 