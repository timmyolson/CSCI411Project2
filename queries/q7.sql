-- 7) Report the catalog item which has been refernced the most.

SELECT * FROM (
   SELECT R.catid, COUNT(R.catid) as num
   FROM Reference R
   GROUP BY R.catid
   ORDER BY COUNT(R.catid) DESC
)
WHERE ROWNUM = 1;