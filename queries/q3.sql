-- 3) Give the year and number of publications for each type of catalog item, that had the highest number of publications for that catalog item.

SELECT * FROM (
   SELECT EXTRACT(year FROM P.publish_date) as publish, COUNT(EXTRACT(year FROM P.publish_date)) as num, C.type
   FROM Book B, Publishes P, Catalog_item C
   WHERE B.bid = P.catid
   AND C.catid = B.bid
   GROUP BY (EXTRACT(year FROM P.publish_date), C.type)
   ORDER BY COUNT(EXTRACT(year FROM P.publish_date)) DESC
)
WHERE ROWNUM = 1
UNION
SELECT * FROM (
   SELECT EXTRACT(year FROM P.publish_date) as publish, COUNT(EXTRACT(year FROM P.publish_date)) as num, C.type
   FROM Journal J, Publishes P, Catalog_item C
   WHERE J.jid = P.catid
   AND C.catid = J.jid
   GROUP BY (EXTRACT(year FROM P.publish_date), C.type)
   ORDER BY COUNT(EXTRACT(year FROM P.publish_date)) DESC
)
WHERE ROWNUM = 1
UNION
SELECT * FROM (
   SELECT EXTRACT(year FROM P.publish_date) as publish, COUNT(EXTRACT(year FROM P.publish_date)) as num, C.type
   FROM Magazine M, Publishes P, Catalog_item C
   WHERE M.mid = P.catid
   AND C.catid = M.mid
   GROUP BY (EXTRACT(year FROM P.publish_date), C.type)
   ORDER BY COUNT(EXTRACT(year FROM P.publish_date)) DESC
)
WHERE ROWNUM = 1
UNION
SELECT * FROM (
   SELECT EXTRACT(year FROM P.publish_date) as publish, COUNT(EXTRACT(year FROM P.publish_date)) as num, C.type
   FROM Conference_proceedings C, Publishes P, Catalog_item C
   WHERE C.cid = P.catid
   AND C.catid = C.cid
   GROUP BY (EXTRACT(year FROM P.publish_date), C.type)
   ORDER BY COUNT(EXTRACT(year FROM P.publish_date)) DESC
)
WHERE ROWNUM = 1;


--    PUBLISH        NUM TYPE
-- ---------- ---------- -------------------------
--       1994          3 Book
--       1996          1 Conference_proceedings
--       2000          2 Magazine
--       2009          1 Journal


-- Justification:
-- In order to get the largest number of publications for a catalog item in a given year
-- the year is first extracted from the date of the publications. Then catalog item is 
-- grouped according to the year. Then it is ordered by the count of the publications that 
-- share a similar year. This is done for all four types of catalog items. The results
-- are UNION'ed because there will be one result from each sub-query.