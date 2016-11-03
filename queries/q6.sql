-- 6) Give the number of items written, edited, total and the names of the three persons who 
--    have contributed the highest number of catalog items.

SELECT * FROM (
   SELECT temp.pname as Name, temp.Edits as Edits, COUNT(wp.catid) as Written, 
                                                     (temp.Edits + COUNT(wp.catid)) as Total
   FROM (
      SELECT ep.pname, ep.pid, COUNT(E.catid) as Edits
      FROM Person ep
        LEFT OUTER JOIN Edits E ON E.pid = ep.pid
      GROUP BY (ep.pname, ep.pid)
        ) temp
   LEFT OUTER JOIN Writes wp ON temp.pid = wp.pid
   GROUP BY (temp.pname, temp.Edits)
   ORDER BY (temp.Edits + COUNT(wp.catid)) DESC
)
WHERE ROWNUM <= 3;

-- NAME                                EDITS    WRITTEN      TOTAL
-- ------------------------------ ---------- ---------- ----------
-- Brandon Horton                          5          5         10
-- Neil Knowles                            6          0          6
-- Graiden Wilkins                         4          2          6


-- Justification:
-- In order to get the number of items written and number of items edited by the same person
-- a double Left outer join was used. This ensures that even if a person didn't contribute in
-- a catagory they are still represented with a 0. The resulting tally of edits and writes
-- are added producing that person's total "contributions".