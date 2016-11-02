-- 1) What is the range (in years) of the age of books in the library.

SELECT temp.old as "Oldest Book", temp.new as "Newest Book", temp.new - temp.old as "Range"
FROM 
(
  SELECT MIN(EXTRACT(year FROM P.publish_date)) as old, MAX(EXTRACT(year FROM P.publish_date)) as new
  FROM Book B, Catalog_item C, Publishes P
  WHERE B.bid = C.catid
  AND C.catid = P.catid
) temp;