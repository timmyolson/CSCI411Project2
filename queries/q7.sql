-- 7) Report the catalog item which has been refernced the most.

SELECT * FROM (
   SELECT R.catid, COUNT(R.catid) as num
   FROM Reference R
   GROUP BY R.catid
   ORDER BY COUNT(R.catid) DESC
)
WHERE ROWNUM = 1;

-- CATID             NUM
-- ---------- ----------
-- NJEQ6977            4


-- Justification:
-- The catalog items in the referenced table are grouped by catid. 
-- Then all we have to do is order by the count of catid and report the
-- top row.