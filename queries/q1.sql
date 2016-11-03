-- 1) What is the range (in years) of the age of books in the library.

SELECT temp.old as "Oldest Book", temp.new as "Newest Book", temp.new - temp.old as "Range"
FROM 
(
  SELECT MIN(EXTRACT(year FROM P.publish_date)) as old, MAX(EXTRACT(year FROM P.publish_date)) as new
  FROM Book B, Catalog_item C, Publishes P
  WHERE B.bid = C.catid
  AND C.catid = P.catid
) temp;


-- Oldest Book Newest Book      Range
-- ----------- ----------- ----------
--        1968        2014         46

-- Justification: 
-- Books are selected by equijoining bid with catid. In order to get the range of ages of books, 
-- the oldest book is selected and then the newest one. The year published is extracted from
-- the dates and then subtracted to find the range.